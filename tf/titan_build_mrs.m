function imgPatch=titan_build_mrs(CImages,M,N)
[m1,m2,n]=size(CImages);
imgPatch=zeros(M,M,N);
for i=1:N
    mp=randsample(4*M,1);
    k=randsample(n,1);
    x=randsample(m1-mp+1,1);
    y=randsample(m2-mp+1,1);
    temp=CImages(x:x+mp-1, y:y+mp-1, k);
    imgPatch(:,:,i)=imresize(temp,[M,M]);
end
end