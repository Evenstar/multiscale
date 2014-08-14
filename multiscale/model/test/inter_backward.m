function x=inter_backward(v,p,s,filter,l)
x=v;
for k=l:-1:1
    v=rev_max_abs_pooling(x,p{k},s{k});
    a=filter{k};
    [r,~,mx,mv]=size(a);
    x=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
    for i=1:mx
        for j=1:mv
            x(:,:,i)=x(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
        end
    end
end
end