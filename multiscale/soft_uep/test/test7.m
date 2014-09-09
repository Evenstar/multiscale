x=double(imread('../data/barbara.png'));
x=x/255;
x=imresize(x,1/4);
a=randn(3,3,5);
[r,~,mv]=size(a);

a=uep_naive_2(x,a,200,1.2e-5);
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end


x=double(imread('../data/barbara.png'));
x=x/255;
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    %v(:,:,j)=soft(v(:,:,j),0.5);
end
recx=zeros(size(x));
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
psnr(x,recx)
norm(v(:),1)