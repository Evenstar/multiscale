img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
%%
%tree
d0=randn(5,5,1,4);
lambda=0.01;
L=100;
for i=1:10
    disp('iteration')
    [recx,coef]=infer_inter_fista(d0,img,L,lambda,30);
    d0=inter_dict_frcg(img,coef,d0,20);
    d0=normalize_4d_dict(d0);
    E(i)=log10(objective_3d(img,d0,coef,lambda));
    E(i)
end
%%
%layer 1
[x,p]=MaxPooling(coef,[2,2]);
d1=randn(5,5,4,8);
lambda=0.01;
L=100;
for i=1:8
    disp('iteration')
    [recx,v]=infer_inter_fista(d1,x,L,lambda,30);
    d1=inter_dict_frcg(x,v,d1,20);
    d1=normalize_4d_dict(d1);
    E(i)=log10(objective_3d(x,d1,v,lambda));
    E(i)
end

%%
%going back
x=project_back(v,d1);
x=rev_max_pooling(x,[2,2]);
%%
x=project_back(x,d0);


%%

filters{1}=randn(5,5,1,4);
filters{2}=randn(5,5,4,8);
L=1000;
lambda=1e-3;
maxiter=3;
[v,p,s]=project_forward(img,filters,L,lambda,maxiter);
%%
x=proj_back(v,p,s,filters,1,2);








