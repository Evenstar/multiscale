img=double(imread('../data/hepburn.jpg'));
img=imresize(img,1/4);

load('../pretrained/dict.mat');

%%
a=randn(1,5);
b=randn(1,14);
x=randn(1,10);
%%
F=@(x)norm(b-conv(a,x),2)^2;
D=zeros(1,10);
for i=1:10
    delta=0.000001;
    y=x;
    y(i)=x(i)+delta;
    D(i)=(F(y)-F(x))/delta;
end
D
%%
2*conv((conv(a,x)-b),fliplr(a),'valid')
%%
a=orth(randn(5,5));
v=zeros(5,14);
for i=1:5
v(i,:)=conv(x,a(i,:));
end
y=zeros(1,10);
for i=1:5
    y=y+conv(v(i,:),fliplr(a(i,:)),'valid');
end
y/5
x
%%
a=[ 0.0352   -0.0854   -0.1350    0.4599    0.8069    0.3327;
    -0.3327    0.8069   -0.4599   -0.1350    0.0854    0.0352];
v=zeros(2,15);
for i=1:2
v(i,:)=conv(x,a(i,:));
end
y=zeros(1,10);
for i=1:2
    y=y+conv(v(i,:),fliplr(a(i,:)),'valid');
end
y/2
x
