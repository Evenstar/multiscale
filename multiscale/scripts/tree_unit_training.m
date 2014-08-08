
%training the first unit
img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=normalize_row(dict);
opt.lambda=1e-3;
opt.L=100;
opt.maxiter=20;
opt.fista_max_iter=30;
opt.cg_max_iter=30;
[newdict,E]=tree_solver(img,dict,opt);

for i=1:4
    subplot(2,2,i);
    imagesc(reshape(newdict(i,:),[5,5]));
    colorbar
end

[recx,coef]=infer_tree_fista_test(dict,img,L,lambda,50);
imdisp(recx)
psnr(img,recx)