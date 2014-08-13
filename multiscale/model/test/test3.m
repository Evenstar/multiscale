img=double(imread('../data/diamond.png'))/255;
img=imresize(img,0.2);
load('../pretrained/dict.mat');
dict1=reshape(dict',[5,5,1,4]);
load('../pretrained/dict16x25.mat');
dict2=reshape(dict',[5,5,4,4]);
%%
opt.filter{1}=randn(5,5,1,6)/8;
opt.filter{2}=randn(5,5,6,12)/8;
opt.filter{3}=randn(5,5,12,24)/8;
opt.lambda=[1e-4,1e-4,1e-4];
opt.maxiter=[300,300,300];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.L=[100,100,100];
[recx,v,p,s]=infer_inter_fista(opt.filter{1},img,opt.L(1),opt.lambda(1),opt.maxiter(1),opt.shape{1});
opt.s{1}=s;
opt.p{1}=p;
%%
[recx,v,p,s]=infer_cur_fista(img,opt,2);
opt.s{2}=s;
opt.p{2}=p;
%%
opt.filter{3}=randn(5,5,12,24)/8;
opt.L(3)=100;
[recx,v,p,s]=infer_cur_fista(img,opt,3);
opt.s{3}=s;
opt.p{3}=p;
imdisp(recx)