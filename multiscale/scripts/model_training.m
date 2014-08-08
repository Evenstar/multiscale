%script training
opt.layers=3;
opt.filter{1}=randn(5,5,1,4);
opt.filter{2}=randn(5,5,4,8);
opt.filter{3}=randn(5,5,8,8);
opt.L=[100,200,1e3];
opt.lambda=[1e-3,1e-3,1e-3];
opt.max_iter=[20,20,20];
opt.fista_iter=[30,30,30];
opt.cg_iter=[20,20,20];
opt.shape{1}=[2,2];
opt.shape{2}=[2,2];
opt.shape{3}=[2,2];
opt.filter=fit_model(img,opt);


%%
opt.L=[100 200 1e3];
opt.fista_iter=[50,50,50];
st=proj_forward(img,opt);
%%
el=3;
u=st.v{el};
ru=u;
x=proj_back(ru,st.p,st.s,opt.filter,1,el);
imdisp(x)
