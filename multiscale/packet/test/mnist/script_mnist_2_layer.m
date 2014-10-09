load('../../data/mnist_uint8.mat');
train_x=double(train_x)/255;
train_x=train_x';
train_x=reshape(train_x,[28,28,60000]);
%%
seqx=zeros(38,38,4,60000);
for i=1:60000
    if mod(i,100)==0
        i
    end
y=transpose(train_x(:,:,i));
x=inter_in_recv(y,mid_dict);
%x=max_abs_pooling(x,[2,2]);
x=x.*(x>0);
v=inter_mid_recv(x,mid_dict);
v=v.*(v>0);
%recx=max_abs_pooling(recx,[2,2]);
seqx(:,:,:,i)=v;
end

%%
seqy=zeros(60000,1);
for i=1:60000
    [a,b]=find(train_y(i,:)~=0);
    seqy(i)=b;
end

%%
seqx=reshape(seqx,[38*38*4,60000]);
seqx=seqx';
%%
save('test_data_1','seqx','seqy','-v7.3')
%%
save('seqy','seqy')