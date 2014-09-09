x=randn(1,10);
b=randn(1,4);
a=randn(1,4);
v=randn(1,16);
F=@(b)norm(x-conv(conv(v,b,'valid'),a,'valid'),2)^2;
D=zeros(1,4);
for i=1:4
    delta=0.000001;
    y=b;
    y(i)=b(i)+delta;
    D(i)=(F(y)-F(b))/delta;
end
D
r=conv(conv(v,b,'valid'),a,'valid')-x;
2*conv((conv(fliplr(v),r,'valid')),fliplr(a),'valid')