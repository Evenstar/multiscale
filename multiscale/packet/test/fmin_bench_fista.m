function [coef,L]=fmin_bench_fista(x,a,v,b,d,tau,eta,maxiter)
[m,n,mv]=size(v);
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

    function out=obj(v)
        v=reshape(v,[m,n,mv]);
        rv=v-b-inter_recv(x,a,v);
        rx=inter_recx(x,a,v)-x+d;
        out=norm(v(:),1)+tau*norm(rv(:),2)^2+eta*norm(rx(:),2)^2;
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
coef=fminunc(@obj,v(:),options);
coef=reshape(coef,[m,n,mv]);
L=log10(obj(coef));
end