x=randn(10,10);
a=randn(4,4);
%%
f=@(a)(norm(x-conv2(conv2(rot90(a,2),x),a,'valid'),'fro')^2);
f(a)
%%
E=zeros(4,4);
delta=1e-8;
for i=1:4
    for j=1:4
        z=a;
        z(i,j)=z(i,j)+delta;
        E(i,j)=(f(z)-f(a))/delta;
    end
end
E
%%
clc
v=conv2(rot90(a,2),x);
rx=conv2(v,a,'valid')-x;
df1=2*conv2(rot90(v,2),rx,'valid');
df2=2*conv2(conv2(a,x),rot90(rx,2),'valid');
df1

