function [newdict,recx]=inter_dict_gd(x,a,u,v,eta,L,maxiter)

k=0;
while k<maxiter
    df=inter_df(x,a,u,v,eta);
    a=a+L*df;
    k=k+1;
    %compute error,debug only
    recx=inter_recx(x,a,u);
    rx=x-recx;
    rv=v-inter_recv(v,a,x);
    E=norm(rx(:),2)^2+eta*norm(rv(:),2)^2;
    log10(E)
end
newdict=a;
end

function recv=inter_recv(v,a,x)
[~,~,mx,mv]=size(a);
recv=zeros(size(v));
for j=1:mv
    for i=1:mx
        recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
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

function df=inter_df(x,a,u,v,eta)
[~,~,mx,mv]=size(a);
df=zeros(size(a));
rx=inter_recx(x,a,u)-x;
rv=inter_recv(v,a,x)-v;
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=df(:,:,i,j)+2*conv2(rot90(u(:,:,j),2),rx(:,:,i),'valid');
        df(:,:,i,j)=df(:,:,i,j)+2*eta*conv2(rv(:,:,j),x(:,:,i),'valid');
    end
end
end

function alpha=inter_alpha(x,a,u,v,p,eta)
    rx=x-inter_recx(x,a,u);
    rv=v-inter_recv(v,a,x);
    px=inter_recx(x,p,u);
    pv=inter_recv(v,p,x);
    sa=dot(rx(:),px(:))+eta*dot(rv(:),pv(:));
    sb=norm(px(:),2)^2+eta*norm(pv(:),2)^2;
    alpha=sa/sb;
end














