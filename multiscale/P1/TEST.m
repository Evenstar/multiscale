x=double(imread('../data/barbara.png'));
x=x/255;
x=imresize(x,1/4);
a=reshape(orth(randn(25,4))/4,[5,5,4]);
a=reshape(dict',[5,5,4])/4;
[r,~,mv]=size(a);
lambda=10^2;
eta=10^3;
%%
for k=1:10
lambda=10;
eta=10^3;
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    v(:,:,j)=soft(v(:,:,j),1/lambda);
end
newdict=update_a(x,a,v,lambda,eta,2);
norm(sort(newdict(:))-sort(dict(:)),2)
a=newdict;
figure(1);
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end
end
%%
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end

fprintf('ratio %6.2f, obj %8.6f,', norm(v(:),1)/lambda/norm(rx(:),2),obje)

E=zeros(1,mv);
for j=1:mv
    E(j)=sum(sum(a(:,:,j)));
end
E
%%

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
