function newdict=inter_dict_frcg(x,v,dict,maxiter)
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
    
    function recv=inter_recv(x,a,v)
        recv=zeros(size(v));
        for j=1:mv
            for i=1:mx
                recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
            end
        end
    end

    function df=inter_df(x,a,v,u)
        df=zeros(size(a));
        recx=inter_recx(x,a,u);
        recv=inter_recv(x,a,v);
        rx=recx-x;
        rv=recv-v;
        for i=1:mx
            for j=1:mv
                df(:,:,i,j)=df(:,:,i,j)+conv2(rot90(u(:,:,j),2),rx(:,:,i),'valid');
                df(:,:,i,j)=df(:,:,i,j)+conv2(rv(:,:,j),x(:,:,i),'valid');
            end
        end
    end
end