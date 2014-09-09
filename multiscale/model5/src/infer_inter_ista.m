function [u,v]=infer_inter_ista(x,a,eta,lambda,shape)
    [r,~,mx,mv]=size(a);
    v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
    for j=1:mv
        for i=1:mx
            v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
        end
        v(:,:,j)=soft(v(:,:,j),lambda/2/eta);
    end
    u=max_abs_pooling_same(v,shape);
end
