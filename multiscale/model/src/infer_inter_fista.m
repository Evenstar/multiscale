function [recx,coef,p,s]=infer_inter_fista(dict,x,L,lambda,maxiter,shape)
mx=size(dict,3);
mv=size(dict,4);
r=size(dict,1);

%initialize coefficients in regular way
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for i=1:mx
    for j=1:mv
        v(:,:,j)=v(:,:,j)+conv2(x(:,:,i),rot90(dict(:,:,i,j),2));
    end
end

%auxiliary variable in FISTA
u=v;
%optimal step size variable in FISTA
t=ones(1,maxiter);

%Here begins the iteration
for k=1:maxiter
    %reconstructed input
    recx=zeros(size(x));
    for i=1:mx
        for j=1:mv
            recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),dict(:,:,i,j),'valid');
        end
    end
    %residual
    rx=recx-x;
    E=log10(norm(rx(:),2))
    vold=v;
    %compute the gradient
    for j=1:mv
        gradvj=zeros(size(v,1),size(v,2));
        for i=1:mx
            gradvj=gradvj+conv2(rot90(dict(:,:,i,j),2),rx(:,:,i));
        end
        cj=u(:,:,j)-2/L*gradvj;
        %soft thresholing in FISTA
        v(:,:,j)=soft(cj,lambda/L);
        %reverse max pooling
        v(:,:,j)=max_abs_pooling_same(v(:,:,j),shape);
    end
    %udpate the auxiliary variables
    t(k+1)=(1+sqrt(1+4*t(k)^2))/2;
    u=v+(t(k)-1)/t(k+1)*(v-vold);
    
end
if E>3
    warning('Failed to converge.');
end
s=size(v);
[coef,p]=max_abs_pooling(v,shape);
end