function newdict=fmincon_test_1(x,a,maxiter)
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
    function out=obj(a)
        a=reshape(a,[r,r,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for j=1:mv
            v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
        out=norm(v(:),1);
    end


    function [c,ceq]=nonlcon(a)
        a=reshape(a,[r,r,mv]);
        A=reshape(a,[r*r,mv]);
        A=A';        
        c=[aw_uep_2d_c(A)-1e-8]
        ceq=[];
        for j=1:mv
            na=norm(a(:,:,j),'fro');
            c=[c; 1/mv-na];
        end
    end
options=optimset('maxiter',maxiter,'MaxFunEvals',20000000, ...
    'Algorithm','Interior-Point','TolCon',1e-9);
newdict = fmincon(@obj,a,[],[],[],[],[],[],@nonlcon,options);
newdict = reshape(newdict,[r,r,mv]);
obj(newdict)
end