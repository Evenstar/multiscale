%%
img=double(imread('../data/barbara.png'));
img=imresize(img,0.5);
img=img/255;
img=img-mean(img(:));
load('../pretrained/dict.mat');
dict=reshape(dict',[5,5,1,4]);
dict=normalize_4d_dict(dict);
%%
%script training
opt.layers=4;
opt.filter{1}=dict;
opt.filter{2}=randn(5,5,4,8);
opt.filter{3}=randn(5,5,8,16);
opt.filter{4}=randn(5,5,16,4);
opt.L=[100,200,1e3,1e3];
opt.lambda=[1e-5,1e-5,1e-5,1e-4];
opt.max_iter=[20,20,20,20];
opt.fista_iter=[30,30,30,30];
opt.cg_iter=[10,10,10,10];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.shape{4}=[2,2];
opt.filter=fit_model(img,opt);


%%
opt.L=[100 200 1e3 1e3];
opt.fista_iter=[50,50,50,50];
st=proj_forward(img,opt);
%%
el=4;
u=st.v{el};
ru=zeros(size(u));
x=proj_back(u,st.p,st.s,opt.filter,1,el);
imdisp(x)
%%
for i=1:4
ru(:,:,i)=u(:,:,i).*(abs(u(:,:,i))>0.00);
x=proj_back(ru,st.p,st.s,opt.filter,1,el);
subplot(3,3,i);
imdisp(x)
end
