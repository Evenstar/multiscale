function [u,idx]=max_abs_pooling(img,shape)
    [v,idx]=MaxPooling(abs(img),shape);
    u=v(:).*sign(img(idx));
    u=reshape(u,size(v));
end