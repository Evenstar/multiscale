%script training
img=double(imread('../data/diamond.png'))/255;
img=imresize(img,0.5);
img=img.*(abs(img)>0.2);
opt.layers=5;
opt.filter{1}=randn(5,5,1,4)/4;
opt.filter{2}=randn(5,5,4,16)/8;
opt.filter{3}=randn(5,5,16,16)/16;
opt.filter{4}=randn(5,5,16,8)/8;
opt.filter{5}=randn(5,5,8,1)/8;
opt.L=[100,500,500,500,500];
opt.lambda=[1e-5,1e-5,1e-5,1e-5,1e-5];
opt.max_iter=[10,10,10,10,10];
opt.fista_iter=[30,30,30,30,30];
opt.cg_iter=[20,20,20,20,20];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.shape{4}=[2,2];
opt.shape{5}=[2,2];
opt.filter=fit_model(img,opt);


%%
opt.L=[100 500 1e3 1e3 1e3 ];
opt.fista_iter=[50,50,50,50,50];
st=proj_forward(img,opt);
%%
el=5;
u=st.v{el};
ru=u;
ru=ru.*(abs(ru)>5*1e-3);
x=proj_back(ru,st.p,st.s,opt.filter,1,el);
imdisp(x(:,:,1))
%%
subplot(3,1,1);
imdisp(img);
subplot(3,1,2);
imdisp(ximg);
subplot(3,1,3);
imdisp(x);
%%
figure(1);
imdisp(ximg);
figure(2);
imdisp(x);
%%
