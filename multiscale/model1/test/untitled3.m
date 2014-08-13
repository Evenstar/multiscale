load('../pretrained/dict.mat');
img=double(imread('../data/barbara.png'));
x=img/255;

m=4;
r=5;
for i=1:m
    a=rot90(reshape(dict(i,:),[r,r]),2);
    v(:,:,i)=conv2(x,a);
end

%%
v(5,5,3)
b=reshape(dict(3,:),[r,r]);
x11=x(1:5,1:5);
dot(b(:),x11(:))

%%
[recx,coef]=infer_tree_fista(dict,img,1000,2,10);
%%
tic
[X,V]=crop_patch(img,coef,5,1000);
toc
tic
[U,~,Q]=svd(V*X');
a=U*eye(size(U,1),size(Q,1))*Q;
toc
imdisp(reshape(a',[5,5,1,4]))