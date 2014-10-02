%% Denoising Test
%load data;
y=double(imread('../../data/barbara.png'))/255;
x=imresize(y,1/2,'cubic');
a=get_initial_guess(y,6,4,20000);
a=reshape(a',[6,6,4]);
[r,~,mv]=size(a);
for j=1:mv
    a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/2;
end
%%
%initialize filters using DB3
[L,H]=wfilters('db3');
a(:,:,1)=L'*L;
a(:,:,2)=L'*H;
a(:,:,3)=H'*L;
a(:,:,4)=H'*H;
a=a/2;
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
%%
c=zeros(size(a));
for j=1:mv
    c(:,:,j)=rot90(a(:,:,j),2);
end
c=fmin_proj_dict(x,c,v,200);
%%
%solve for filters
tic
a=fmincon_test(x,a,v,3000);
toc
%%
[L,H]=wfilters('db3');
a(:,:,1)=L'*L;
a(:,:,2)=L'*H;
a(:,:,3)=H'*L;
a(:,:,4)=H'*H;
wa=a/2;
%%
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
v=inter_recv(x,a,v);
norm(v(:),1)
%%
v=inter_recv(x,wa,v);
norm(v(:),1)