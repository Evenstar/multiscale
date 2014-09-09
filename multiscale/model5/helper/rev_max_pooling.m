function [mimg,idx]=rev_max_pooling(img,shape)
    [~,idx]=MaxPooling(abs(img),shape);
    mimg=zeros(size(img));
    mimg(idx)=img(idx);
end
