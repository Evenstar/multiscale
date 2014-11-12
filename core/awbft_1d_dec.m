function coef=awbft_1d_dec(x,a,f)
[m,r]=size(a);
coef=zeros(m,length(x)+r-1);
for i=1:m
    temp=conv(x,a(i,:));
    coef(i,1:f:end)=temp(1:f:end);
end
end
