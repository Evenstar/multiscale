%%
x=randn(100,100);
a=randn(5,5,1)/5;
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    v(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
b=randn(size(v));
d=randn(size(x));
eta=1;
%%
bregman_update_dict_gd(x,a,v,b,d,eta,10)