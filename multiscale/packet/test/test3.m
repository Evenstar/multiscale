x=double(imread('../data/barbara.png'))/255;
x=imresize(x,1/4);
load('a6.mat');
a=randn(6,6,4)/4;
[r,~,mv]=size(a);
u=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
v=zeros(size(u));
b=zeros(size(u));
lambda=1000;
tau=1000;
eta=1000;
maxiter=2;
%set initial value of u
for j=1:mv
    u(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end

for k=1:2
%update v
for j=1:mv
    v(:,:,j)=soft(u(:,:,j),1/lambda/2);
end

%update u
w=zeros(size(v));
for j=1:mv
    w(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    u(:,:,j)=(lambda*v(:,:,j)+tau/2*(w(:,:,j)+b(:,:,j)))/(lambda+tau/2);
end

%update a
a=fmin_update_dict(x,a,u,b,eta,tau,maxiter);

%update b
w=zeros(size(v));
for j=1:mv
    w(:,:,j)=conv2(rot90(a(:,:,j),2),x);
    b(:,:,j)=b(:,:,j)+w(:,:,j)-u(:,:,j);
end

log10(bregman_objective(x,u,v,a,b,lambda,eta,tau))
end
%%
%display a
for j=1:mv
    subplot(2,2,j);
    imagesc(a(:,:,j))
end

A=reshape(a,[36,4]);
A=A';
st=wtfdec2(x,A,2,1);
recx=wtfrec2(st);
psnr(x,recx)









