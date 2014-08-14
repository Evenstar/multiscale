%%
img=double(imread('../data/diamond.png'))/255;
img=imresize(img,0.2);
opt.filter{1}=randn(5,5,1,4)/8;
opt.filter{2}=randn(5,5,4,8)/8;
opt.filter{3}=randn(5,5,8,12)/8;
opt.filter{4}=randn(5,5,12,8)/8;
opt.filter{5}=randn(5,5,8,4)/8;
%%
opt.lambda=[1e-4,1e-4,1e-4,1e-4,1e-4];
opt.outer_iter=[50,50,50,50,50];
opt.cg_iter=[2 2 2,2,2];
opt.fista_iter=[1,1,1,1,1];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.shape{4}=[2,2];
opt.shape{5}=[2,2];
opt.L=[100,100,100,100,100];
[recx,newopt]=learn_multiple_layers(img,opt,5);
opt=newopt;

%%
opt.fista_iter=[50,50,50,50,50];
[recx,v,p,s]=infer_multiple_layers(img,opt,5);