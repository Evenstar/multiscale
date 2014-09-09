img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');

%%
dict=randn(4,r*r);
lambda=0.001;
L=100;
for i=1:200
    disp('iteration')
    [recx,coef]=infer_tree_fista_test(dict,img,L,lambda,50);
    dict0=dict;
   % [dict]=tree_dict_prcg_test(img,coef,dict,4);
   % log10(objective(img,coef,dict,lambda))
   %  [X,V]=crop_patch(img,coef,5,10000);
   %  [U,~,Q]=svd(V*X');
   %  dict=U*eye(size(U,1),size(Q,1))*Q;
     dict=test_func_2(img,dict,coef,50);
      dict=normalize_dict(dict);
    E(i)=log10(objective(img,coef,dict,lambda));
    E(i)
end
%%
clc
dict=randn(4,25);
dict=normalize_dict(dict);
newdict=tree_dict_frcg_test(img,coef,dict,10);
%%
newdict=test_func_2(img,dict,coef,10);
imdisp(reshape(newdict',[5,5,1,4]))

%%

for i=1:4
    subplot(2,2,i);
    imagesc(reshape(dict(i,:),[r,r]));
    colorbar
end