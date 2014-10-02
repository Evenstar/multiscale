x=rand(50,50);
a=randn(5,5,2)/5;
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
v=v+randn(size(v))*1;
b=randn(size(v));
d=randn(size(x));
tau=10;
eta=10;
L=50;
%%
pdict=fmin_proj_dict(x,a,v,100);
%%
x=randn(1,10);
%%
v=inter_recv(x,a,v);
b=zeros(size(v));
d=zeros(size(d));
tau=0;
eta=1;
%%
v=inter_recv(x,a,v);
[a,E]=bregman_update_dict_frcg(x,a,v,b,d,tau,eta,20);
for j=1:mv
    a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/sqrt(2);
end
%%
v=inter_recv(x,a,v);

recx=inter_recx(x,a,v);
psnr(x,recx)
















%%

x=double(imread('../data/barbara.png'))/255;
x=imresize(x,1/8);
load('a.mat');
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
v=inter_recv(x,a,v);

%%
for k=1:10
v=inter_recv(x,a,v);
v=soft(v,0.01);
olda=a;
a=fmin_proj_dict(x,a,v,5);
a=0.9*olda+0.1*a;
for j=1:mv
    a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/sqrt(mv);
end
end












