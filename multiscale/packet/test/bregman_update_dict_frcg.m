function [newdict]=bregman_update_dict_frcg(x,a,v,b,d,eta,maxiter)
[r,~,mv]=size(a);
    function recv=inter_recv(a,x)
        recv=zeros(size(v));
        for j=1:mv
            recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
    end

    function recx=inter_recx(a,v)
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
        end
    end

    function out=loss(dict)
        recv=inter_recv(dict,x);
        rv=v-recv-b;
        E1=norm(rv(:),2)^2;
        recx=inter_recx(dict,v);
        rx=x-recx-d;
        E2=norm(rx(:),2)^2;
        out=E1+eta*E2;
    end

    function df=inter_df(dict)
        df=zeros(size(dict));
        rv=inter_recv(dict,x)+b-v;
        rx=inter_recx(dict,v)+d-x;
        for j=1:mv
            df(:,:,j)=2*conv2(rv(:,:,j),rot90(x,2),'valid');
            df(:,:,j)=df(:,:,j)+2*eta*conv2(rot90(v(:,:,j),2),rx,'valid');
        end
    end

    function alpha=inter_alpha(p)
        pv=inter_recv(p,x);
        rv=inter_recv(a,x)+b-v;
        px=inter_recx(p,v);
        rx=inter_recx(a,v)+d-x;
        sa=dot(pv(:),rv(:))+eta*dot(px(:),rx(:));
        sb=norm(pv(:),2)^2+eta*norm(px(:),2)^2;
        alpha=sa/sb;
    end

k=0;
df=inter_df(a);
p=-df;
while k<maxiter
    alpha=inter_alpha(p)
        LOSS=log10(loss(a))
    a=a+alpha*df;
        LOSS=log10(loss(a))
    ndf=inter_df(a);
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    p=-ndf+beta*df;
    k=k+1;

end
end