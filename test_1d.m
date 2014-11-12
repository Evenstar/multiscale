a=[-0.1294    0.2241    0.8365    0.4830;
    -0.4830    0.8365   -0.2241   -0.1294];
a=[-0.1294    0.2241    0.8365    0.4830;
    0 0 0 0;]
r=4;
m=3;
df=1;
%a=randn(m,r);
%a=a(1:m,:);
[A,f,b]=gen_coef_mat(a,df);
size(A)
[err,d]=awbft_1d_err(randn(1,100),fliplr(a),b,df)
%%
for k=1:100
r=randi(100);
M=randi(r);
count=count_equations(r,M)-(2*r-M)*M;
if count~=0
    warning('wrong');
end
end