seqx=double(train_x)/255;
seqy=zeros(60000,1);
for i=1:60000
    [a,b]=find(train_y(i,:)~=0);
    seqy(i)=b;
end
save('mnist_raw','seqx','seqy')
