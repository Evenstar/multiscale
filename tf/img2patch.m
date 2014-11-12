function imgPatch=img2patch(CImages, patchSize)
%No boundary check is included in this version, that said, the pathSize must
%divide the image size.
[m,n,p]=size(CImages);
M=patchSize(1);
N=patchSize(2);
k1=floor(m/M);
k2=floor(n/N);
imgPatch=zeros(M,N,k1*k2*p);
cnt=1;
for k=1:p
    tempImg=CImages(:,:,k);
    for i=1:k1
        for j=1:k2
            tempPatch=tempImg((i-1)*M+1:i*M,(j-1)*N+1:j*N);
            imgPatch(:,:,cnt)=tempPatch;
            cnt=cnt+1;
        end
    end
end

end