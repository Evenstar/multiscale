function [newdict,recx,v]=uep_inter_naive(x,a,maxiter,lambda)
[r,~,mx,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            for i=1:mx
                v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
        recx=zeros(size(x));
        v(1:2:end,1:2:end,:)=0;
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
            end
        end
        rx=recx-x;
        out=norm(rx(:),2)+lambda*norm(v(:),1);
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mx,mv]);

        a=reshape(newdict,[r,r,mx,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            for i=1:mx
                v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
        recx=zeros(size(x));
               v(1:2:end,1:2:end,:)=0;
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
            end
        end
        rx=recx-x;
        psnr(x(:),recx(:))
        norm(v(:),1)
        out=norm(rx(:),2)+lambda*norm(v(:),1);
end