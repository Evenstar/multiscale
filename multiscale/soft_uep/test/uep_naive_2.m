function newdict=uep_naive_2(x,a,maxiter,lambda)
 [r,~,mv]=size(a);
    function out=obj(a)
       a=reshape(a,[r,r,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        A=reshape(a,[r*r,mv]);
        A=A';
        out=sqrt(aw_uep_2d_c(A))+lambda*norm(v(:),1);
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
end