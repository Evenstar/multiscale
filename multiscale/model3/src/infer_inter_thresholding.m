function [u,v]=infer_inter_thresholding(dict,x,lambda,shape)
mx=size(dict,3);
mv=size(dict,4);
r=size(dict,1);

%compute coefficients in regular way
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(x(:,:,i),rot90(dict(:,:,i,j),2));
    end
    v(:,:,j)=soft(v(:,:,j),1/lambda);
end
u=max_abs_pooling_same(v,shape);
end