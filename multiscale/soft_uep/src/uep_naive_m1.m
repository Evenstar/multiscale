function [newdict]=uep_naive_m1(x,a,maxiter,lambda)
[r,~,mx,mv]=size(a);
y=randn(200,200,mx);
    function out=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            for i=1:mx
                v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
        
        u=zeros(size(y,1)+r-1,size(y,2)+r-1,mv);
        for j=1:mv
            for i=1:mx
                u(:,:,j)=u(:,:,j)+conv2(rot90(a(:,:,i,j),2),y(:,:,i));
            end
        end
        recy=zeros(size(y));
        for i=1:mx
            for j=1:mv
                recy(:,:,i)=recy(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
            end
        end
        ry=recy-y;
        out=lambda*norm(ry(:),2)+norm(v(:),1);
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mx,mv]);
end