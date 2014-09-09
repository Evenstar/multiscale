function [X V]=crop_patch(img,coef,r,N)
    [nx,ny]=size(img);
    m=size(coef,3);
    k=1;
    X=zeros(r*r,N);
    V=zeros(m,N);
    while k<N
        i=randsample(nx-r+1,1);
        j=randsample(ny-r+1,1);
        X(:,k)=reshape(img(i:i+r-1,j:j+r-1),[r*r,1]);
        V(:,k)=reshape(coef(i+r-1,j+r-1,:),[m,1]);
        k=k+1;
    end
end