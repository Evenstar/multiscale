function coef=awbft_2d_dec(x,a)
    [~,r,m]=size(a);
    coef=zeros(size(x,1)+r-1,size(x,2)+r-1,m);
    for i=1:m
        coef(:,:,i)=conv2(x,a(:,:,i));
    end
end