img=double(imread('../data/barbara.png'));
%img=imresize(img,1/4);

load('../pretrained/dict.mat');
dict=dict/5;
m=size(dict,1);
r=sqrt(size(dict,2));
v=zeros(size(img,1)+r-1,size(img,2)+r-1,m);

L=100;
lambda=1;

for i=1:m
    a=rot90(reshape(dict(i,:),[r,r]),2);
    v(:,:,i)=conv2(img,a);
end



%%
L=1;
lambda=1;
for k=1:100
img_rec=zeros(size(img));
for i=1:m
    a=reshape(dict(i,:),[r,r]);
    img_rec=img_rec+conv2(v(:,:,i),a,'valid');
end
res=img_rec-img;
% norm(res(:),2)^2+lambda*norm(v(:),1);
% norm(res(:),2)
psnr(img,img_rec)
for i=1:m
    a=rot90(reshape(dict(i,:),[r,r]),2);
    v(:,:,i)=v(:,:,i)-2/L*conv2(res,a);
    v(:,:,i)=soft(v(:,:,i),lambda/L);
    v(:,:,i)=rev_max_pooling(v(:,:,i),[2,2]);
end
end
%%
L=1;
lambda=1;
for k=1:100
img_rec=zeros(size(img));
for i=1:m
    a=reshape(dict(i,:),[r,r]);
    img_rec=img_rec+conv2(v(:,:,i),a,'valid');
end
res=img_rec-img;
% norm(res(:),2)^2+lambda*norm(v(:),1);
% norm(res(:),2)
psnr(img,img_rec)
for i=1:m
    a=rot90(reshape(dict(i,:),[r,r]),2);
    v(:,:,i)=v(:,:,i)-2/L*conv2(res,a);
    v(:,:,i)=soft(v(:,:,i),lambda/L);
    v(:,:,i)=rev_max_pooling(v(:,:,i),[2,2]);
end
end
%%
img_rec=zeros(size(img));
for i=[3,4,1,2]
    a=reshape(dict(i,:),[r,r]);
    img_rec=img_rec+conv2(v(:,:,i),a,'valid');
    figure(i);
    imdisp(img_rec)
end











