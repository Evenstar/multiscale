function recx=inter_recx(x,a,v)
recx=zeros(size(x));
[~,~,mv]=size(a);
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
end