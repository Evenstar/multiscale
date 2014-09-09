%%
%learn multiple images
img=double(imread('../data/barbara.png'))/255.0;
opt.filter{1}=randn(7,7,1,6)/12;
opt.filter{2}=randn(7,7,6,12)/12;

opt.lambda=[1e-4,1e-5,1e-4,1e-4,1e-4]*100;
opt.outer_iter=[1,1,1,1,1]*20;
opt.cg_iter=[2 2 2,2,2]*5;
opt.fista_iter=[1,1,1,1,1]*5;
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.shape{4}=[2,2];
opt.shape{5}=[2,2];
opt.L=[100,100,100,100,100];
%%
[recx,newopt]=learn_multiple_layers(img,opt,2);
sum(sum(sum(sum(abs((newopt.filter{1}-opt.filter{1}))))));
opt=newopt;
imdisp(recx)
%%
opt.fista_iter=[1,1,1,1,1]*20;
[recx,v,p,s]=infer_multiple_layers(img,opt,1);
psnr(img,recx)
imdisp(recx)