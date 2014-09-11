x=randn(20,20,2);
a=randn(4,4,2,3);
%%
clc
numericdf=ndf(x,a,@func);
numericdf(:,:,1,2)
df=inter_df(x,a);
df(:,:,1,2)
df2=inter_df2(x,a);
df2(:,:,1,2)
%%
x=double(imread('../../model5/data/barbara.png'));
x=x/255;
x=imresize(x,0.5);
L=1/50;
%a=randn(4,4,1,3);
for k=1:10000
    df=normalize_4d_dict(inter_df2(x,a));
    a=a-1/k*df;
    log10(func(x,a))
end