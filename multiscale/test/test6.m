%%
img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
%%
%tree
d0=randn(5,5,1,4);
lambda=0.001;
L=100;
for i=1:20
    disp('iteration')
    [recx,coef]=infer_inter_fista(d0,img,L,lambda,30);
    d0=inter_dict_frcg(img,coef,d0,20);
    d0=normalize_4d_dict(d0);
    E(i)=log10(objective_3d(img,d0,coef,lambda));
    E(i)
end
%%
[recx,coef]=infer_inter_fista(d0,img,L,lambda,30);
%%
%expect 0
[u,p]=max_abs_pooling(coef,[2,2]);
s=size(coef);
recu=rev_max_abs_pooling(u,p,s);
norm(coef(:)-recu(:),2)
%%
[u,p]=max_abs_pooling(coef,[2,2]);
s=size(coef);
recu=rev_max_abs_pooling(u,p,s);
rx=proj_back_unit(recu,d0);
imdisp(rx)
%%
[x,p1]=max_abs_pooling(coef,[2,2]);
d1=randn(5,5,4,8);
lambda=0.001;
L=200;
for i=1:10
    disp('iteration')
    [recxv]=infer_inter_fista(d1,x,L,lambda,30);
    d1=inter_dict_frcg(x,v,d1,20);
    d1=normalize_4d_dict(d1);
    E(i)=log10(objective_3d(x,d1,v,lambda));
    E(i)
end
%%
[u,p2]=max_abs_pooling(v,[2,2]);
s=size(v);
recu=rev_max_abs_pooling(u,p,s);
rv=proj_back_unit(recu,d1);
ru=rev_max_abs_pooling(rv,p1,size(coef));
rx=proj_back_unit(ru,d0);
imdisp(rx)
%%
pp{1}=p1;
pp{2}=p;
f{1}=d0;
f{2}=d1;
ss{1}=size(coef);
ss{2}=size(v);
%%
ru=u.*(abs(u)>0.05);
x=proj_back(ru,pp,ss,f,1,2);
imdisp(x)







%%
opt.layers=2;
opt.filter{1}=randn(5,5,1,4);
opt.filter{2}=randn(5,5,4,8);
opt.filter{3}=randn(5,5,8,8);
opt.L=[100,200,1e3];
opt.lambda=[1e-3,1e-3,1e-3];
opt.max_iter=[10,10,30];
opt.fista_iter=[30,30,30];
opt.cg_iter=[20,20,20];
newfilter=fit_model(img,opt)
opt.filter=newfilter;
%%

 






















