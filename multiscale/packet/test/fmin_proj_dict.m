function pdict=fmin_proj_dict(x,a,v,maxiter)
[r,~,mv]=size(a);
    function df=inter_df(x,a,v)
        df=zeros(size(a));
        rx=inter_recx(x,a,v)-x;
        for j=1:mv
            df(:,:,j)=2*conv2(rot90(v(:,:,j),2),rx,'valid');
        end
    end
    function [out,df]=obj(a)
        a=reshape(a,[r,r,mv]);
        rx=inter_recx(x,a,v)-x;
        out=norm(rx(:),'fro');
        df=inter_df(x,a,v);
        df=df(:);
    end
obj(a)
options=optimset('maxiter',maxiter,'MaxFunEval',2000000,'TolFun',1e-9);
pdict=fminunc(@obj,a(:),options);
pdict=reshape(pdict,[r,r,mv]);
obj(pdict)
end