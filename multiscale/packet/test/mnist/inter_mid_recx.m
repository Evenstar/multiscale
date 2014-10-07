function recx=inter_mid_recx(a,v)
[r,~,mx,mv]=size(a);
recx=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end