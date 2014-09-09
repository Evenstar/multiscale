function [newdict,recx]=inter_uep_beta(x,a,maxiter)
[r,~,mx,mv]=size(a);
sizev=[size(x,1)+r-1,size(x,2)+r-1,mv];
for outer=1:80
    eta=1e-1;
    v=inter_recv(sizev,a,x);
    v=soft(v,1/500);
    df=inter_df(x,a,v,eta);
    p=-df;
    k=0;
    while k<maxiter
        alpha=inter_alpha(x,a,v,p,eta);
        a=a+alpha*p;
        ndf=inter_df(x,a,v,eta);
        beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
        p=-ndf+beta*df;
        k=k+1;
        
    end
    newdict=a;
    recx=inter_recx(size(x),a,v);
    E=norm(recx(:)-x(:),2);
    log10(E)
end
end


function recx=inter_recx(sizex,a,v)
recx=zeros(sizex);
[~,~,mx,mv]=size(a);
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end

function recv=inter_recv(sizev,a,x)
recv=zeros(sizev);
[~,~,mx,mv]=size(a);
for j=1:mv
    for i=1:mx
        recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
end

function df=inter_df(x,a,v,eta)
[~,~,mx,mv]=size(a);
df=zeros(size(a));
rx=inter_recx(size(x),a,v)-x;
rv=inter_recv(size(v),a,x)-v;
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=2*conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
        df(:,:,i,j)=df(:,:,i,j)+2*eta*conv2(rv(:,:,j),x(:,:,i),'valid');
    end
end
end

function alpha=inter_alpha(x,a,v,p,eta)
rx=x-inter_recx(size(x),a,v);
rv=v-inter_recv(size(v),a,x);
px=inter_recx(size(x),p,v);
pv=inter_recv(size(v),p,x);

sa=dot(rx(:),px(:))+eta*dot(rv(:),pv(:));
sb=norm(px(:),2)^2+eta*norm(pv(:),2)^2;

alpha=sa/sb;
end