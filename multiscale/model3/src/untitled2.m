img=double(imread('../../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
%%
lambda=1e10;
shape=[2,2];
maxiter=20;
 [u,v]=infer_inter_thresholding(dict,img,lambda,shape);
 %%
 
 newdict=infer_dict_cur_frcg(img,u,v,randn(size(dict)),maxiter);
%%
 [newdict]=fit_model(img,dict,lambda,shape)