function x=awbft_2d_rec(v,b)
[~,r,m]=size(b);
x=zeros(size(v,1)-r+1,size(v,2)-r+1);
for i=1:m
    x=x+conv2(v(:,:,i),b(:,:,i),'valid');
end
end