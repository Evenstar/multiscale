function [newdict,recx]=inter_uep_simple(x,a,v,maxiter)
df=inter_df(x,a,v);
p=-df;
k=0;
while k<maxiter
    alpha=inter_alpha(x,a,v,p);
    a=a+alpha*p;
    ndf=inter_df(x,a,v);
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    p=-ndf+beta*df;
    k=k+1;
    recx=inter_recx(x,a,v);
    E=norm(recx(:)-x(:),2);
    log10(E)
end
newdict=a;
end

function recx=inter_recx(x,a,u)
[~,~,mx,mv]=size(a);
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
    end
end
end

function df=inter_df(x,a,v)
[~,~,mx,mv]=size(a);
df=zeros(size(a));
rx=inter_recx(x,a,v)-x;
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=2*conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
    end
end
end

function alpha=inter_alpha(x,a,v,p)
rp=inter_recx(x,p,v);
rx=x-inter_recx(x,a,v);
sa=dot(rp(:),rx(:));
sb=norm(rp(:),2)^2;
alpha=sa/sb;
end