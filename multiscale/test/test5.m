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
for i=1:30
    disp('iteration')
    [recx,coef]=infer_inter_fista(d0,img,L,lambda,30);
    d0=inter_dict_frcg(img,coef,d0,20);
    d0=normalize_4d_dict(d0);
    E(i)=log10(objective_3d(img,d0,coef,lambda));
    E(i)
end
%%
%layer 1
[x,p]=max_abs_pooling(coef,[2,2]);
d1=randn(5,5,4,8);
lambda=0.001;
L=200;
for i=1:10
    disp('iteration')
    [recx,v]=infer_inter_fista(d1,x,L,lambda,30);
    d1=inter_dict_frcg(x,v,d1,20);
    d1=normalize_4d_dict(d1);
    E(i)=log10(objective_3d(x,d1,v,lambda));
    E(i)
end

%%
%going back
x=project_back(v,d1);
x=rev_max_pooling(x,[2,2]);
%%
x=zeros(256,256);
[v,idx]=max_abs_pooling(coef,[2,2]);
u=zeros(size(v,1)*2,size(v,2)*2,size(v,3));
u(idx)=v;
for i=1:4
    x=x+conv2(u(:,:,i),d0(:,:,1,i),'valid');
end
imdisp(x)
%%
coef=coef(1:20,1:20,1);
[v,idx]=max_abs_pooling(coef,[2,2]);
u=zeros(size(v,1)*2,size(v,2)*2,size(v,3));
u(idx)=v;
norm(u(:)-coef(:),2)








%%
clear filters
filters{1}=d0;
filters{2}=d1;
L=1000;
lambda=1e-3;
maxiter=30;
[v,p]=proj_forward(img,filters,L,lambda,maxiter);
%%
u=zeros(size(v{2}));
u(30,30,1)=1;
x=proj_back(u,p,filters,1,2);
imdisp(x)
%%
imdisp(recx)




%%
%script training
opt.layers=3;
opt.filter{1}=randn(5,5,1,4);
opt.filter{2}=randn(5,5,4,8);
opt.filter{3}=randn(5,5,8,8);
opt.L=[100,200,1e3];
opt.lambda=[1e-3,1e-3,1e-3];
opt.max_iter=[20,20,20];
opt.fista_iter=[30,30,30];
opt.cg_iter=[20,20,20];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.filter=fit_model(img,opt);


%%
opt.L=[100 200 1e3];
opt.fista_iter=[50,50,50];
st=proj_forward(img,opt);
%%
el=3;
u=st.v{el};
ru=u;
x=proj_back(ru,st.p,st.s,opt.filter,1,el);
imdisp(x)



































