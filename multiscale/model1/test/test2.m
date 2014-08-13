
x=randn(10,10);
dict=randn(5,5);
v=randn(14,14);
F=@(a)norm(x-conv2(v,a,'valid'),2)^2;
%%
F(a)
p=conv2(rot90(v,2),conv2(v,a,'valid')-x,'valid');
a=a-1e-5*p;
F(a)

%%
F(a)
tic
dict=reshape(a,[1,25]);
[recx,newdict]=tree_dict_gd(x,v,dict,1e-5,100);
a=reshape(newdict,[5,5]);
toc
F(a)

%%
df=conv2(rot90(v,2),conv2(v,a,'valid')-x,'valid');
p=-df;
tic
for i=1:5
F(a)
r1=x-conv2(v,a,'valid');
r2=conv2(v,p,'valid');
alpha=dot(r1(:),r2(:))/norm(r2(:),2)^2;
a=a+alpha*p;
ndf=conv2(rot90(v,2),conv2(v,a,'valid')-x,'valid');
beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
p=-ndf+beta*df;
end
toc
%%
clc
x=randn(200,200);
dict=randn(4,25);
v=randn(204,204,4);
obj(x,v,dict)

 tic
 [recx,newdict]=tree_dict_gd(x,v,dict,1e-5,10);
 toc
 obj(x,v,newdict)
tic
[recx,newdict]=tree_dict_frcg(x,v,dict,10);
toc
obj(x,v,newdict)















