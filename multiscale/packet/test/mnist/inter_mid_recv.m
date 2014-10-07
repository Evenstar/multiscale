function v=inter_mid_recv(x,a)
[r,~,mx,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for i=1:mx
    for j=1:mv
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
end