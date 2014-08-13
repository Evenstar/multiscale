img=double(imread('../data/barbara.png'));
img=img/255;
load('../pretrained/dict.mat');

%%
dict=normalize_dict(dict);
for i=1:10
[recx,coef]=infer_tree_fista_test(dict,img,1000,0.1,1);
[dict]=tree_dict_gd_test(img,coef,dict,1e-7,2);
dict=normalize_dict(dict);
log10(objective(img,coef,dict,0.001))
end


%%
dict=normalize_dict(dict);
for i=1:20
[recx,coef]=infer_tree_ista(dict,img,100,2,3);
norm(recx-img)
[X,V]=crop_patch(img,coef,5,2000);
[U,~,Q]=svd(V*X');
dict=U*eye(size(U,1),size(Q,1))*Q;
dict=fliplr(dict);
end