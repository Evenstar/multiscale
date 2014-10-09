%%
y=double(Img)/255;
x=inter_in_recv(y,a);
x=imresize(x,1/2);
%%
tic
mid_dict=randn(6,6,4,4)/4;
u=inter_mid_recv(x,mid_dict);
[mid_dict,E]=update_mid_dict_frcg(x,mid_dict,u,10);
toc
plot(E)
%%
[newdict,E]=fmin_update_mid_dict(x,mid_dict,u,1)

%%
v=inter_mid_recv(x,mid_dict);
v=soft(v,1/1000);
u=v;
% u(1:2:end,:,:)=0;
% u(:,1:2:end,:)=0;
[mid_dict,E]=update_mid_dict_frcg(x,mid_dict,u,20);
%%
[r,~,mx,mv]=size(mid_dict);
for i=1:mx
    for j=1:mv
        subplot(mx,mv,(i-1)*mv+j);
        imagesc(mid_dict(:,:,i,j));
    end
end
%%
tic;[mid_dict,E]=fmin_update_mid_dict(x,mid_dict,u,100,10);toc
%%
y=double(Img)/255;
x=inter_in_recv(y,a);
x=x./max(abs(x(:)));
recx=inter_mid_recx(mid_dict,inter_mid_recv(x,mid_dict));
recx=recx./max(abs(recx(:)));
norm(recx(:),1)
%recx=soft(recx,1/50);
norm(recx(:),1)
%recx=max_abs_pooling(recx,[2,2]);
imdisp(recx(:,:,4))