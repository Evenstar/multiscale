x=double(imread('../data/barbara.png'));
y=x/255;
x=[];
x(:,:,1)=y(1:100,1:100);
x(:,:,2)=y(200:299,200:299);
a=randn(4,4,2,4);
[r,~,mx,mv]=size(a);

[a,recx,v]=uep_inter_naive(x,a,200,0);
%%
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,2,i),[]);
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
%%
k=1;
for i=1:2
    for j=1:4
        E(k)=sum(sum(a(:,:,i,j)));
        k=k+1;
    end
end
sort(E)