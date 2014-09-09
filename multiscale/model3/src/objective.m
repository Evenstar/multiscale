function obj=objective(x,a,u,v)
[~,~,mx,mv]=size(a);
    function recx=inter_recx(x,a,u)
        %compute reconstructed input
        recx=zeros(size(x));
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
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
recx=inter_recx(x,a,u);
recv=inter_recv(x,a,v);
obj=sum((x(:)-recx(:)).^2)+sum((v(:)-recv(:)).^2);
end