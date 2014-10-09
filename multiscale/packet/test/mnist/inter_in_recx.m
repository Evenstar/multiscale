function recx=inter_in_recx(a,v)
[r,~,mv]=size(a);
recx=zeros(size(v,1)-r+1,size(v,2)-r+1);
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
end