img=double(imread('../../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=dict/(sqrt(trace(dict'*dict)));
dict=reshape(dict',[5,5,1,4]);
%dict=normalize_4d_dict(dict);
x=img;
a=dict;

%%
for i=1:10
[u,v]=infer_inter_ista(x,a,1,1e-3,[2,2]);
[newdict,recx]=inter_dict_frcg(x,a,u,v,1e-2,5);
a=newdict;
end
%%
newdict=test_numeric(x,a,u,v,1,10)