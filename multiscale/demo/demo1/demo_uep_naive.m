x=double(imread('../data/barbara.png'));
x=x/255;
x=imresize(x,1/4);
a=reshape((randn(16,4))/4,[4,4,4]);
a=randn(7,7,4);
%a=reshape(dict',[5,5,4]);
[r,~,mv]=size(a);
lambda=3*10^3;
[a,v,rx,obje]=fun_uep_naive(x,a,200,lambda);
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end

fprintf('ratio %6.2f, obj %8.6f,', norm(v(:),1)/lambda/norm(rx(:),2),obje)

x=double(imread('../data/barbara.png'));
x=x/255;
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
recx=zeros(size(x));
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
psnr(x,recx)
log10(norm(v(:),1))

E=zeros(1,mv);
for j=1:mv
    E(j)=sum(sum(a(:,:,j)));
end
E
