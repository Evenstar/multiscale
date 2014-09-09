function newdict=uep_naive_2(x,a,maxiter,lambda,eta)
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    v(:,:,j)=soft(v(:,:,j),lambda/2/eta);
end

    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
        end
        rx=recx-x;
        
        rv=zros(size(v));
        for j=1:mv
            rv(:,:,j)=v(:,:,j)-conv2(rot90(a(:,:,j),2),x);
        end
        out=norm(rx(:),2)^2+lambda*norm(rv(:),2)^2;
    end
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mv]);
end