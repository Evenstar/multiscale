function [newdict]=inter_dict_frcg(x,v,dict,maxiter)
[~,~,mx,mv]=size(dict);

    function recx=inter_recx(x,a,v)
        %compute reconstructed input
        recx=zeros(size(x));
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
            end
        end
    end

    function df=inter_df(x,a,v)
        %compute gradient
        df=zeros(size(a));
        recx=inter_recx(x,a,v);
        rx=recx-x;
        for i=1:mx
            for j=1:mv
                df(:,:,i,j)=conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
            end
        end
    end

    function alpha=inter_alpha(x,a,v,p)
        %compute alpha in PRCG
        recx=inter_recx(x,a,v);
        rx=x-recx;
        rp=zeros(size(x));
        for i=1:mx
            for j=1:mv
                rp(:,:,i)=rp(:,:,i)+conv2(v(:,:,j),p(:,:,i,j),'valid');
            end
        end     
        sa=0;
        for i=1:mx
            vrx=rx(:,:,i);
            vrp=rp(:,:,i);
            sa=sa+dot(vrx(:),vrp(:));
        end
        sb=0;
        for i=1:mx
            vrp=rp(:,:,i);
            sb=sb+norm(vrp(:),2)^2;
        end
        alpha=sa/sb;
    end
%compute gradient
df=inter_df(x,dict,v);
%initialize search direction
p=-df;
%begin iteration
k=0;
while k<maxiter
    alpha=inter_alpha(x,dict,v,p);
    %update dict
    dict=dict+alpha*p;
    %compute new gradient
    ndf=inter_df(x,dict,v);
    %compute beta
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %update search direction
    p=-ndf+beta*df;
    k=k+1;
    recx=inter_recx(x,dict,v);
    E=log10(norm(recx(:)-x(:),2));
end
newdict=dict;
if E>3
    warning('Failed to converge');
end

end

