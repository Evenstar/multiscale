function newdict=update_a(x,a,v,lambda,eta,maxiter)
    [r,~,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        recv=zeros(size(v));
        for j=1:mv
            recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        rv=v-recv;
        u=zeros(size(v));
        for j=1:mv
            u(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(u(:,:,j),a(:,:,j),'valid');
        end
        rx=x-recx;
        out=lambda*norm(rv(:),2)^2+eta*norm(rx(:),2)^2;
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
end