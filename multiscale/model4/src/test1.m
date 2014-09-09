img=double(imread('../../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
x=img;
a=dict;
%%
[u,v]=infer_inter_ista(x,a,10,[2,2]);
%%
newdict2=inter_b_frcg(x,a,v,200);
%%
%test gradient
a=randn(1,4);
x=randn(1,10);
v=randn(1,13);
F=@(a)norm(v-conv(a,x),2)^2;
delta=1e-8;
for i=1:4
    b=a;
    b(i)=a(i)+delta;
    E(i)=(F(b)-F(a))/delta;
end
E
2*conv2(conv(a,x)-v,fliplr(x),'valid')
%%
newdict=test_numeric(x,a,v,10)

%%
%test training
lambda=10;
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
a=dict;
b=a;
[~,~,mx,mv]=size(a);
for i=1:mx
    for j=1:mv
        b(:,:,i,j)=rot90(a(:,:,i,j),2);
    end
end
for k=1:50
    [u,v]=infer_inter_ista(x,a,lambda,[2,2]);
    a=inter_a_frcg(x,a,v,5);
    a=normalize_4d_dict(a);
    %b=inter_b_frcg(x,a,u,10);
    %b=normalize_4d_dict(b);
end

%%
        recx=zeros(size(x));
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),b(:,:,i,j),'valid');
            end
        end
imdisp(recx(:,:,1))
