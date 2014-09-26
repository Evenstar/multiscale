function newdict=fmin_update_dict(x,a,u,b,eta,tau,maxiter)
[r,~,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(u(:,:,j),a(:,:,j),'valid');
        end
        rx=x-recx;
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        rv=u-v-b;
        out=eta*norm(rx(:),2)^2+tau/2*norm(rv(:),2)^2;
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);

end