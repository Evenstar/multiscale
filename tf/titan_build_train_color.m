function imgPatch=titan_build_train_color(CImages,M,N)
[m1,m2,~,n]=size(CImages);
imgPatch=zeros(M,M,3,N);
for i=1:N
    k=randsample(n,1);
    x=randsample(m2-M+1,1);
    y=randsample(m1-M+1,1);
    patch=CImages(y:y+M-1,x:x+M-1,:,k);
    imgPatch(:,:,:,i)=patch;
end
imgPatch=reshape(imgPatch,[M,M*3,N]);
end