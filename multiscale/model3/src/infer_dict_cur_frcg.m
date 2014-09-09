function newdict=infer_dict_cur_frcg(x,u,v,dict,maxiter)
[~,~,mx,mv]=size(dict);
    function recx=inter_recx(u,a)
        recx=zeros(size(x));
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
            end
        end
    end

    function recv=inter_recv(x,a)
        recv=zeros(size(v));
        for j=1:mv
            for i=1:mx
                recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
    end

    function df=inter_df(x,a,u,v)
        df=zeros(size(a));
        recx=inter_recx(u,a);
        recv=inter_recv(x,a);
        rx=recx-x;
        rv=recv-v;
        for i=1:mx
            for j=1:mv
                df(:,:,i,j)=2*conv2(rot90(u(:,:,j),2),rx(:,:,i),'valid');
                df(:,:,i,j)=df(:,:,i,j)+2*conv2(rv(:,:,j),x(:,:,i),'valid');
            end
        end
    end

    function alpha=inter_alpha(x,a,u,v,p)
        rx=x-inter_recx(u,a);
        rv=v-inter_recv(x,a);
        rpx=inter_recx(u,p);
        rpv=inter_recv(x,p);
        sa=dot(rx(:),rpx(:))+dot(rv(:),rpv(:));
        sb=dot(rpx(:),rpx(:))+dot(rpv(:),rpv(:));
        alpha=sa/sb;
    end

df=inter_df(x,dict,u,v);
p=-df;
k=0;
while k<maxiter
    alpha=inter_alpha(x,dict,u,v,p);
    odict=dict;
    dict=dict+alpha*p;
    norm(dict(:)-odict(:))
    ndf=inter_df(x,dict,u,v);
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    p=-ndf+beta*df;
    rx=x-inter_recx(u,dict);
    rv=v-inter_recv(x,dict);
   E=norm(rx(:))^2+norm(rv(:))^2;
   log10(E);
    k=k+1;
end
recx=inter_recx(u,dict);
imdisp(recx)
newdict=dict;
end