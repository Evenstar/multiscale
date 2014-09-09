%%
%learn multiple images
load('../../common/data/flower160.mat');
opt.filter{1}=randn(7,7,1,6)/12;
opt.filter{2}=randn(5,5,6,18)/12;

opt.lambda=[1e-4,1e-4,1e-4,1e-4,1e-4]*100;
opt.outer_iter=[1,1,1,1,1];
opt.cg_iter=[2 2 2,2,2];
opt.fista_iter=[1,1,1,1,1]*2;
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.L=[100,100,100,100,100];
%%
for k=1:1
for i=1:80
img=CImages(:,:,i)/255;
[recx,newopt]=learn_multiple_layers(img,opt,1);
sum(sum(sum(sum(abs((newopt.filter{1}-opt.filter{1}))))))
opt=newopt;
end
end
%%
img=CImages(:,:,3)/255;
opt.fista_iter=[50,50,50,50,50];
opt.lambda=[1e-4,1e-4,1e-4,1e-4,1e-4]*100;
[recx,v,p,s]=infer_multiple_layers(img,opt,1);
psnr(img,recx)
imdisp(recx)