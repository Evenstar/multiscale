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
a=randn(5,5,1,6);
[newdict,recx]=inter_uep_beta(x,a,3);
a=newdict;
for i=1:6
    subplot(2,2,i);
    imagesc(newdict(:,:,1,i));
end

%%
figure(2)
for i=1:4
    subplot(2,2,i);
    imagesc(a(:,:,1,i));
end