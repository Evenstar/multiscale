    function [v]=inter_forward(x,filter,p,l)
        v=zeros([size(x),1]);
        v(:,:,1)=x;
        for k=1:l
            a=filter{k};
            [r,~,mx,mv]=size(a);
            u=zeros(size(v,1)+r-1,size(v,2)+r-1,mv);
            for j=1:mv
                for i=1:mx
                    u(:,:,j)=u(:,:,j)+conv2(rot90(a(:,:,i,j),2),v(:,:,i));
                end
            end
            idx=p{k};
            m=zeros(size(u));
            m(idx)=1;
            u=u.*m;
            v=max_abs_pooling(u,[2,2]);
        end
        
    end