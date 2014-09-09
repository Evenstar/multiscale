img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict16x25.mat');
dict=reshape(dict',[5,5,4,4]);
%%

dict=randn(5,5,1,5);
dict=normalize_4d_dict(dict);
dict=randn(4,25);
dict=normalize_row(dict);
tic
[recx,coef]=infer_tree_fista(dict, img, 100, 1e-3,200);
toc
psnr(img,recx)

dict=reshape(dict',[5,5,1,4]);
tic
[recx,coef]=infer_inter_fista(dict, img, 100, 1e-3,200);
toc
psnr(img,recx)
%%
dict=randn(5,5,4,4);
 [dict]=inter_dict_frcg(x,coef,dict,30);
 %%

 dict=randn(5,5,4,8);
 [recx,coef]=infer_inter_fista(dict, x, 1000, 1e-3,100);


