%This is a simple demo that generates 4 filters of support 5x5 using a
%single image. Initial value is produced by another approximation program,
%for demonstration purpose, we load the pre-trained value.
x=double(imread('../data/barbara.png'))/255;
x=imresize(x,1/4);
%load pre-trained initial value.
load('dict.mat');
a=reshape(dict',[5,5,4])/4;
%a=(randn([5,5,4]))/4;
[r,~,mv]=size(a);
%set value of lambda.
lambda=10^2;

%call traning program
[a,v,rx,obje]=fun_demo1(x,a,500,lambda);

%display filters
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end

%check element sum of each filter
E=zeros(1,mv);
for j=1:mv
    E(j)=sum(sum(a(:,:,j)));
end
E

recx=zeros(size(x));
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
psnr(x,recx)
log10(norm(v(:),1))
