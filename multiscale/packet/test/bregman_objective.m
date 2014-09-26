function out=bregman_objective(x,u,v,a,b,lambda,eta,tau)
[r,~,mv]=size(a);
    out=0;
    out=out+norm(u(:),1);
    ru=u-v;
    out=out+lambda*norm(ru(:),2)^2;
    
    recx=zeros(size(x));
    for j=1:mv
        recx=recx+conv2(u(:,:,j),a(:,:,j),'valid');
    end
    rx=x-recx;
    out=out+eta*norm(rx(:),2)^2;
    
    w=zeros(size(u));
    for j=1:mv
        w(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    end
    rv=u-w-b;
    out=out+tau/2*norm(rv(:),2)^2;
end