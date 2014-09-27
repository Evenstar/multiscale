function [newdict,L]=fmin_bench(x,a,v,b,d,tau,eta,maxiter)
[r,~,mv]=size(a);
    function recv=inter_recv(x,a,v)
        recv=zeros(size(v));
        [~,~,mv]=size(a);
        for j=1:mv
            recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
    end

    function recx=inter_recx(x,a,v)
        recx=zeros(size(x));
        [~,~,mv]=size(a);
        for j=1:mv
            recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
        end
    end

    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        recv=inter_recv(x,a,v);
        rv=recv+b-v;
        E1=norm(rv(:),2)^2;
        recx=inter_recx(x,a,v);
        rx=recx+d-x;
        E2=norm(rx(:),2)^2;
        out=tau*E1+eta*E2;
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
L=log10(obj(newdict))
end
