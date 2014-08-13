function [recx,v,p,s]=infer_inter_fista(x,opt,l)


%begins the main part of this function, computing the coefficients of the
%currelt layer, that is, layer l.

%update size of current coefficient
a=opt.filter{l};
[r,~,mx,mv]=size(a);

%initialize coefficient of current layer
if l>1
    u=inter_forward(x,opt.filter,opt.p,l-1);
else
    u(:,:,1)=x;
end
v=zeros(size(u,1)+r-1,size(u,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(u(:,:,i),rot90(a(:,:,i,j),2));
    end
end

%auxiliary variable in FISTA
w=v;
%optimal step size variable in FISTA
t=ones(1,opt.maxiter(l));

%here begins the iteration
for k=1:opt.maxiter(l)
    %reconstruct the input
    u=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
    for i=1:mx
        for j=1:mv
            u(:,:,i)=u(:,:,i)+conv2(w(:,:,j),a(:,:,i,j),'valid');
        end
    end
    if l>1
        recx=inter_backward(u,opt.p,opt.s,opt.filter,l-1);
    else
        recx=u;
    end
    rx=recx-x;
    vold=v;
    %compute the gradient
    if l > 1
        u=inter_forward(rx,opt.filter,opt.p,l-1);
    else
        u=rx;
    end
    gradv=zeros(size(v));
    for j=1:mv
        for i=1:mx
            gradv(:,:,j)=gradv(:,:,j)+conv2(rot90(a(:,:,i,j),2),u(:,:,i));
        end
    end
    for j=1:mv
        v(:,:,j)=v(:,:,j)-2/opt.L(l)*gradv(:,:,j);%wrong
        v(:,:,j)=soft(v(:,:,j),opt.lambda(l)/opt.L(l));
    end
    v=rev_max_pooling(v,opt.shape{l});
    %update the auxiliary variables
    t(k+1)=(1+sqrt(1+4*t(k)^2))/2;
    w=v+(t(k)-1)/t(k+1)*(v-vold);
end
s=size(v);
[v,p]=max_abs_pooling(v,opt.shape{l});
end


function v=inter_pooling_fixed(u,p,s,shape)
m=zeros(s);
m(p)=1;
u=u.*m;
v=max_abs_pooling(u,shape);
end

function u=inter_rev_pooling_fixed(v,p,s)
u=zeros(s);
u(p)=v;
end

function [v]=inter_forward(x,filter,p,l)
v=zeros([size(x),1]);
v(:,:,1)=x;
for k=1:l
    a=filter{k};
    [r,~,mx,mv]=size(a);
    u=zeros(size(v,1)+r-1,size(v,2)+r-1,mv);
    for j=1:mv
        for i=1:mx
            u(:,:,j)=u(:,:,j)+conv2(rot90(a(:,:,i,j),2),v(:,:,i));
        end
    end
    v=inter_pooling_fixed(u,p{k},size(u),[2,2]);
end
end

function x=inter_backward(v,p,s,filter,l)
x=v;
for k=l:-1:1
    v=inter_rev_pooling_fixed(x,p{k},s{k});
    a=filter{k};
    [r,~,mx,mv]=size(a);
    x=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
    for i=1:mx
        for j=1:mv
            x(:,:,i)=x(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
        end
    end
end
end