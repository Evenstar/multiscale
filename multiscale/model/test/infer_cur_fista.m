function [recx,v,p,s]=infer_cur_fista(x,opt,l)
%for first layer, call a simpler sovler.
if l==1
    [recx,v,p,s]=infer_inter_fista(opt.filter{1},x,opt.L(1),opt.lambda(1),opt.fista_iter(1),opt.shape{1});
    return;
end

dict=opt.filter{l};
[r,~,mx,mv]=size(dict);

%initialize coefficients in regular way
u=inter_forward(x,opt.filter,opt.p,l-1);
v=zeros(size(u,1)+r-1,size(u,2)+r-1,mv);
for  j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(u(:,:,i),rot90(dict(:,:,i,j),2));
    end
end

%auxiliary variable in FISTA
y=v;
%optimal step size variable in FISTA
t=ones(1,opt.fista_iter(l));

%begins iteration
for k=1:opt.fista_iter(l)
    %compute residual
    recu=zeros(size(u));
    for i=1:mx
        for j=1:mv
            recu(:,:,i)=recu(:,:,i)+conv2(y(:,:,j),dict(:,:,i,j),'valid');
        end
    end
    recx=inter_backward(recu,opt.p,opt.s,opt.filter,l-1);
    rx=recx-x;
    E=log10(norm(rx(:),2));
    vold=v;
    %compute gradient
    u=inter_forward(rx,opt.filter,opt.p,l-1);
    for j=1:mv
        gradvj=zeros(size(v,1),size(v,2));
        for i=1:mx
            gradvj=gradvj+conv2(rot90(dict(:,:,i,j),2),u(:,:,i));
        end
        %gradient step
        cj=y(:,:,j)-2/opt.L(l)*gradvj;
        %thresholding step
        v(:,:,j)=soft(cj,opt.lambda(l)/opt.L(l));
    end
    %max pooling step
    v=max_abs_pooling_same(v,opt.shape{l});
    %update auxiliary variables
    t(k+1)=(1+sqrt(1+4*t(k)^2))/2;
    y=v+(t(k)-1)/t(k+1)*(v-vold);
end
s=size(v);
%output downsampled coefficients and positions of local maximum.
[v,p]=max_abs_pooling(v,opt.shape{l});
if E>3
    warning('Failed to converge.');
end
end


