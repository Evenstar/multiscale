function recv=inter_recv(x,a,v)
recv=zeros(size(v));
[~,~,mv]=size(a);
for j=1:mv
    recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
end