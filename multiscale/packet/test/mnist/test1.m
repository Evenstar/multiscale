%% Use initial guess one layer transform
% DESCRIPTIVE TEXT
clear
load('../../data/mnist_uint8.mat');
load('mnist400.mat');
dict=get_initial_guess(Img,4,6,20000);
dict_in=reshape(dict',[4,4,6]);
[r,~,mv]=size(dict_in);
N=60000;
seqx=zeros(N,(28+r-1)*(28+r-1)*mv);
train_x=double(train_x)/255;
train_x=reshape(train_x,[60000,28,28]);
train_x=permute(train_x,[2,3,1]);
%%
dict_mid=get_initial_guess(Img,6,36,20000);
dict_mid=reshape(dict_mid',[6,6,6,6]);
%%
tic
v=inter_in_recv(train_x(:,:,1),dict_in);
u=inter_mid_recv(v,dict_mid);
m=prod(size(u));
seqx=zeros(N,m);
N=60000;
parfor i=1:N
    v=inter_in_recv(train_x(:,:,i),dict_in);
    v=v.*(v>0);
    u=inter_mid_recv(v,dict_mid);
    seqx(i,:)=u(:).*(u(:)>0);
end

seqy=zeros(N,1);
parfor i=1:N
    [a,b]=find(train_y(i,:)~=0);
    seqy(i)=b;
end
save('mnist_myfilter','seqx','seqy','-v7.3')
toc

%%
