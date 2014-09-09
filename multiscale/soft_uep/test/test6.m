x=double(imread('../data/barbara.png'));
x=x/255;
x=imresize(x,1/4);
a=randn(3,3,5);
[r,~,mv]=size(a);

%%
a=randn(3,3,5);
lambda=1e-2;
L=1e-3;
for l=1:100
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    v(:,:,j)=soft(v(:,:,j),lambda);
end



for k=1:3
recx=zeros(size(x));
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
rx=recx-x;
log10(norm(rx(:),2));
df=zeros(size(a));
for j=1:mv
    df(:,:,j)=conv2(rot90(v(:,:,j),2),rx,'valid');
end
a=a-1/k*normalize_4d_dict(df);
end
end
%%
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
norm(v(:),1)
