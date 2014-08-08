function [recx,coef]=infer_tree_fista(dict, x, L, lambda,maxIter)
%number of filters
m=size(dict,1);     
%size of filters
r=sqrt(size(dict,2));  
%reshape dict
a=zeros(r,r,m); 
for i=1:m
    a(:,:,i)=reshape(dict(i,:),[r,r]);
end
%initialize the variables
v=zeros(size(x,1)+r-1,size(x,2)+r-1,m);
for i=1:m
    b=rot90(a(:,:,i),2);
    v(:,:,i)=conv2(x,b);
end
%variable used in FISTA algorithm
u=v;  
%step size variable used in FISTA algorithm
t=ones(1,maxIter);

%start the iteration
for k=1:maxIter
    %reconstructed image
    recx=zeros(size(x));
    for i=1:m
        recx=recx+conv2(u(:,:,i),a(:,:,i),'valid');
    end
    %the residual of recovery
    rx=recx-x; 
    %record values of the previous step
    vold=v;
    %compute the gradient
    for i=1:m
        b=rot90(a(:,:,i),2);
        c=u(:,:,i)-2/L*conv2(rx,b);
        v(:,:,i)=soft(c,lambda/L);
        v(:,:,i)=rev_max_pooling(v(:,:,i),[2,2]);
    end
    %update the auxiliary variables
    t(k+1)=(1+sqrt(1+4*t(k)^2))/2;
    u=v+(t(k)-1)/t(k+1)*(v-vold);
end
coef=v;
end