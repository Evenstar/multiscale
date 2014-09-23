function [newdict,v,rx,obje]=fun_demo1(x,a,maxiter,lambda)
[r,~,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        
        %compute recx
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
        end
        rx=recx-x;
        
        out=norm(v(:),1)+lambda*norm(rx(:),1);
    end

options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
obje=log10(obj(newdict));
end