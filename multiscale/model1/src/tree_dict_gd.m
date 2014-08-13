function [newdict]=tree_dict_gd(x,v,dict,delta,maxiter)
m=size(dict,1);
r=sqrt(size(dict,2));
recx=zeros(size(x));
for k=1:maxiter
    %compute residual
    recx=zeros(size(x));
    for i=1:m
        a=reshape(dict(i,:),[r,r]);
        recx=recx+conv2(v(:,:,i),a,'valid');
    end
    rx=recx-x;
    norm(rx,2)
    %compute the gradient
    for i=1:m
        da=2*conv2(rot90(v(:,:,i),2),rx,'valid');
        dict(i,:)=dict(i,:)-delta*transpose(da(:));
    end
end
newdict=dict;
end

