function newdict=inter_a_frcg(x,a,v,maxiter)
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
    recv=inter_recv(x,a,v);
    E=log10(norm(recv(:)-v(:),2));
end
newdict=a;
E
end

function recv=inter_recv(x,a,v)
[~,~,mx,mv]=size(a);
recv=zeros(size(v));
for j=1:mv
    for i=1:mx
        recv(:,:,j)=recv(:,:,j)+conv2(a(:,:,i,j),x(:,:,i));
    end
end
end

function df=inter_df(x,a,v)
[~,~,mx,mv]=size(a);
df=zeros(size(a));
recv=inter_recv(x,a,v);
rv=recv-v;
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=2*conv2(rv(:,:,j),rot90(x(:,:,i),2),'valid');
    end
end
end

function alpha=inter_alpha(x,a,v,p)
rp=inter_recv(x,p,v);
rv=v-inter_recv(x,a,v);
sa=dot(rp(:),rv(:));
sb=norm(rp(:),2)^2;
alpha=sa/sb;
end