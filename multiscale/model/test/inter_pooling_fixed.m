function v=inter_pooling_fixed(u,p,s,shape)
m=zeros(s);
m(p)=1;
u=u.*m;
v=max_abs_pooling(u,shape);
end