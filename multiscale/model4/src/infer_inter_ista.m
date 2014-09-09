function [u,v]=infer_inter_ista(x,a,lambda,shape)
    [r,~,mx,mv]=size(a);
    v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
    for j=1:mv
        for i=1:mx
            v(:,:,j)=v(:,:,j)+conv2(x(:,:,i),a(:,:,i,j));
        end
        v(:,:,j)=soft(v(:,:,j),1/lambda);
    end
    u=max_abs_pooling_same(v,shape);
end
