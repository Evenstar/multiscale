CImages=train_x';
CImages=reshape(CImages,[28,28,60000]);
IDX=randperm(60000);
CImages(:,:,1:60000)=CImages(:,:,IDX);
%%
M=20;
Img=zeros(28*M,28*M);
k=1;
for i=1:M
    for j=1:M
        Img((i-1)*28+1:i*28,(j-1)*28+1:j*28)=transpose(CImages(:,:,k));
        k=k+1;
    end
end
%%
imdisp(Img)
save('mnist400','Img')