function [recx,v]=infer_tree_soft(dict,x,lambda,shape)
mx=size(dict,3);
mv=size(dict,4);
r=size(dict,1);

%initialize coefficients in regular way
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(x(:,:,i),rot90(dict(:,:,i,j),2));
    end
    v(:,:,j)=soft(v(:,:,j),lambda);
end

 for j=1:mv
     v(:,:,j)=rev_max_pooling(v(:,:,j),shape);
 end
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),dict(:,:,i,j),'valid');
    end
end

end