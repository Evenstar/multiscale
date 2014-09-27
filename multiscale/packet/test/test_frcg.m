%
x=rand(50,50);
a=randn(5,5,1)/5;
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
v=v+randn(size(v))*1;
b=randn(size(v));
d=randn(size(x));
tau=0;
eta=10;
%%
tic
[newdict,L]=bregman_update_dict_frcg(x,a,v,b,d,tau,eta,50);
toc
[bdict,bL]=fmin_bench(x,a,v,b,d,tau,eta,2000);
norm(newdict(:)-bdict(:),1)

%%
% a=randn(1,5);
% x=randn(1,10);
% v=randn(1,14);
% F=@(a) norm(v-conv(fliplr(a),x),2)^2;
% h=1e-8;
% for i=1:5
%     E=a;
%     E(i)=E(i)+h;
%     D(i)=(F(E)-F(a))/h;
% end
% D
% 2*conv(fliplr(conv(fliplr(a),x)-v),x,'valid')