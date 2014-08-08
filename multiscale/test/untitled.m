img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
%%
r=5;
dict=randn(4,r*r);
lambda=0.001;
L=100;

for i=1:50
    disp('iteration')
    [recx,coef]=infer_tree_fista_test(dict,img,L,lambda,50);
    log10(objective(img,coef,dict,lambda))
    dict=tree_dict_frcg_test(img,coef,dict,10);
    dict=normalize_dict_svd(dict);
    E(i)=log10(objective(img,coef,dict,lambda));
end

for i=1:4
    subplot(2,2,i);
    imagesc(reshape(dict(i,:),[5,5]));
    colorbar
end
%%
r=5;
fimg=zeros(512,512);
fimg(250:250+r-1,250:250+r-1)=reshape(newdict(4,:),[r,r]);
f=fftshift(log(abs(fft2(fimg))+1));
imshow(f,[])

%%

img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=normalize_row(dict);
opt.lambda=1e-3;
opt.L=20;
opt.maxiter=100;
opt.fista_max_iter=10;
opt.cg_max_iter=10;
[newdict,E]=tree_solver(img,dict,opt);

%%
for i=1:4
    subplot(2,2,i);
    imagesc(reshape(newdict(i,:),[5,5]));
    colorbar
end

%%
 [recx,coef]=infer_tree_fista(dict,img,L,lambda,50);
 imdisp(recx)














