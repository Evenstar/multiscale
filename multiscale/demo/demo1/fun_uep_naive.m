function [newdict,v,ry,obje]=fun_uep_naive(x,a,maxiter,lambda)
[r,~,mv]=size(a);
y=unifrnd(0,1,size(x));
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
        
%         %compute recy
        u=zeros(size(v));
        for j=1:mv
            u(:,:,j)=conv2(rot90(a(:,:,j),2),y);
        end
        recy=zeros(size(y));
        for j=1:mv
            recy=recy+conv2(u(:,:,j),a(:,:,j),'valid');
        end
        ry=recy-y;
        
        out=norm(v(:),1)+lambda*norm(ry(:),2);
    end

options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
y=x;
obje=log10(obj(newdict));
end