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
x=img;
eta=1;
L=1e-6;
maxiter=50;
[r,~,mx,mv]=size(a);
[newdict,recx]=inter_uep_gd(x,a,v,eta,L,maxiter);

%%
x=img;
[r,~,mx,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
maxiter=1;
for k=1:500
    
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
    %v(:,:,j)=soft(v(:,:,j),1/300);
end

[newdict,recx]=inter_uep_simple(x,a,v,maxiter);
a=newdict;
%a=normalize_4d_dict(a)/25;
end