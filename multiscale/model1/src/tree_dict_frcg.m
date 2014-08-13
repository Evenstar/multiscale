function [newdict]=tree_dict_frcg(x,v,dict,maxiter)
m=size(dict,1);
r=sqrt(size(dict,2));
a=reshape(dict',[r,r,m]);
%initialize the variables
df=zeros(size(a));

%compute the gradient
recx=zeros(size(x));
for i=1:m
    recx=recx+conv2(v(:,:,i),a(:,:,i),'valid');
end
rx=recx-x;
for i=1:m
    df(:,:,i)=conv2(rot90(v(:,:,i),2),rx,'valid');
end
%initialize search direction
p=-df;

%begin iteration
k=0;
while k<maxiter
    %compute alpha
    recx=zeros(size(x));
    for i=1:m
        recx=recx+conv2(v(:,:,i),a(:,:,i),'valid');
    end
    rx=x-recx;
    rp=zeros(size(x));
    for i=1:m
        rp=rp+conv2(v(:,:,i),p(:,:,i),'valid');
    end
    alpha=dot(rx(:),rp(:))/norm(rp(:),2)^2;
    %update a
    a=a+alpha*p;
    %compute new gradient
    recx=zeros(size(x));
    for i=1:m
        recx=recx+conv2(v(:,:,i),a(:,:,i),'valid');
    end
    rx=recx-x;
    norm(rx,2);
    ndf=zeros(size(a));
    for i=1:m
        ndf(:,:,i)=conv2(rot90(v(:,:,i),2),rx,'valid');
    end
    %compute beta
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %update search direction
    p=-ndf+beta*df;
    %iteration counter
    k=k+1;
end
newdict=transpose(reshape(a,[25,4]));
end