%%
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
x=double(imread('../data/barbara.png'))/255;
x=imresize(x,1/4);
a=randn(5,5,4)/sqrt(sum(a(:).^2));
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
v=inter_recv(x,a,v);
b=zeros(size(v));
d=zeros(size(x));
tau=1;
eta=5;
L=100;
%%
v=zeros(size(v));
b=zeros(size(b));
d=zeros(size(d));
%%
L=60;
[v,E]=bregman_update_coef_fista(x,a,v,b,d,tau,eta,L,100);
[a,W]=bregman_update_dict_frcg(x,a,v,b,d,tau,eta,100);
figure(1);
subplot(2,1,1);
plot(E);
subplot(2,1,2);
plot(W);
%%
x=double(imread('../data/barbara.png'))/255;
x=imresize(x,1/4);
load('a.mat');
[r,~,mv]=size(a);
for j=1:mv
    a(:,:,j)=a(:,:,j)/sqrt(sum(sum(a(:,:,j).^2)))/2;
end

v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
tau=1e3;
eta=1e3;
b=zeros(size(v));
d=zeros(size(x));

%%
tic
tau=1e1;
eta=1e1;
for k=1:1000
    L=1000;
    %v=bregman_update_coef_fista(x,a,v,b,d,tau,eta,L,1);
    v=soft(inter_recv(x,a,v),1/L);
    for l=1:5
        a=bregman_update_dict_frcg(x,a,v,b,d,tau,eta,10);
        for j=1:mv
            a(:,:,j)=a(:,:,j)/sqrt(sum(sum(a(:,:,j).^2)))/2;
        end
    end
    figure(1);
    for l=1:4
        subplot(2,2,l);
        imagesc(a(:,:,l));
    end
    %    b=b+inter_recv(x,a,v)-v;
    %d=d+inter_recx(x,a,v)-x;
    if mod(k,1)==0
        tol1=bregman_infeasibility_v(x,a,v);
        tol2=bregman_infeasibility_x(x,a,v)
    end
end
toc
bregman_infeasibility_lowfrequency(a)