a=randn(1,5);
x=randn(1,10);
E=@(a)norm(conv(fliplr(a),x),2)^2;
2*conv(conv(a,x),fliplr(x),'valid')
for i=1:5
    y=a;
    y(i)=y(i)+1e-8;
    D(i)=(E(y)-E(a))/1e-8;
end
D