function newdict=sparsity_step(x,a,maxiter)
    options=optimset('maxiter',maxiter);
    [r,~,mx,mv]=size(a);
    
    function out=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        out=0;
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            for i=1:mx
            v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
        out=norm(v(:),1);
    end
    newdict=fminunc(@obj,a(:),options);
    newdict=reshape(newdict,[r,r,mx,mv]);
end