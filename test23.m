
a=orth(randn(3,3));
a=a(1:2,:);
H=[a(1,1) a(1,2) a(1,3) a(2,1) a(2,2) a(2,3);
     0 a(1,1) a(1,2) 0 a(2,1) a(2,2);
     0 0 a(1,1) 0 0 a(2,1);
     a(1,2) a(1,3) 0 a(2,2) a(2,3) 0;
     a(1,3) 0 0 a(2,3) 0 0];
f=[1 0 0 0 0]';
c=H\f
c=reshape(c,[3,2])'
%%
x=randn(1,100);
awbft_1d_err(x,fliplr(a),c,1)
check_biframe(a,c)