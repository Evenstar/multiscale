function x=awbft_1d_rec(v,b)
    [m,r]=size(b);
    x=zeros(1,size(v,2)-r+1);
    for i=1:m
        x=x+conv(v(i,:),b(i,:),'valid');
    end
end