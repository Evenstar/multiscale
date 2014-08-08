function [recx,coef]=infer_tree_ista(dict, x, L, lambda, maxIter)
%number of filters
m=size(dict,1);
%size of fiters
r=sqrt(size(dict,2));
%reshape dict
a=zeros(r,r,m);
for i=1:m
    a(:,:,i)=reshape(dict(i,:),[r,r]);
end
%initialize variables
v=zeros(size(x,1)+r-1,size(x,2)+r-1,m);
for i=1:m
    b=rot90(a(:,:,i),2);
    v(:,:,i)=conv2(x,b);
end

%start iteration
for k=1:maxIter
    %reconstructed image
    recx=zeros(size(x));
    for i=1:m
        recx=recx+conv2(v(:,:,i),a(:,:,i),'valid');
    end
    %reconstruction error
    rx=recx-x;
    log(objective(x,v,dict,lambda))
    for i=1:m
        b=rot90(a(:,:,i),2);
        c=v(:,:,i)-2/L*conv2(rx,b);
        v(:,:,i)=soft(c,lambda/L);
        v(:,:,i)=rev_max_pooling(v(:,:,i),[2,2]);
    end
    coef=v;
end
