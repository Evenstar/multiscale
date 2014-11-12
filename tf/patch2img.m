function CImages=patch2img(imgPatch,imgSize)
[M,N,P]=size(imgPatch);
m=imgSize(1); n=imgSize(2);
k1=floor(m/M);
k2=floor(n/N);
numImages=floor(P/k1/k2);
CImages=zeros(m,n,numImages);

cnt=1;
for i=1:numImages
    tempPatch=imgPatch(:,:,(cnt-1)*k1*k2+1:cnt*k1*k2);
    tempImg=zeros(m,n);
    for j=1:k1
        for k=1:k2
            tempImg((j-1)*M+1:j*M,(k-1)*N+1:k*N)=tempPatch(:,:,(j-1)*k2+k);
        end
    end
    CImages(:,:,cnt)=tempImg;
    cnt=cnt+1;
end

end