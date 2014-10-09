function recv=inter_in_recv(x,a)
[r,~,mv]=size(a);
recv=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
end