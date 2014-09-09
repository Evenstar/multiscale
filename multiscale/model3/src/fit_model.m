function [newdict]=fit_model(x,dict,lambda,shape)

    [u,v]=infer_inter_thresholding(dict,x,lambda,shape);
    [r,~,mx,mv]=size(dict);
    function recx=inter_recx(x,a,u)
    %compute reconstructed input
    recx=zeros(size(x));
    for i=1:mx
        for j=1:mv
            recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
        end
    end
    end
    
    function recv=inter_recv(x,a,v)
    recv=zeros(size(v));
    for j=1:mv
        for i=1:mx
            recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
        end
    end
    end
    function obj=objective(a)
    a=reshape(a,[r,r,mx,mv]);
    recx=inter_recx(x,a,u);
    recv=inter_recv(x,a,v);
    obj=sum((x(:)-recx(:)).^2)+sum((v(:)-recv(:)).^2);
    end
for k=1:10
    [u,v]=infer_inter_thresholding(dict,x,lambda,shape);
    dict=fminunc(@objective,dict(:),optimset('MaxIter',2));
    objective(dict)
end
newdict=dict;
end