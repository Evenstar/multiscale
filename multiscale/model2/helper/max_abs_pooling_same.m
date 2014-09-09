function [mimg,idx]=max_abs_pooling_same(img,shape)
    [~,idx]=MaxPooling(abs(img),shape);
    mimg=zeros(size(img));
    mimg(idx)=img(idx);
end
