
%%
N=5000;
r=4;
[c,s]=wavedec(randn(1,N),1,'db2');
len=length(c);
t=sprand(1,len,0.1);
x=waverec(t,s,'db2');
Y=x;
X=sample_1d(x,2000,r);
plot(Y)
%%

[l,h]=wfilters('db2');
DB=[l;h];
r=4;
a=orth(randn(4));
a=a(1:2,:);
%%
[A]=tf_1d_adm(DB,X,1000,0.01,Y);

A
DB

















