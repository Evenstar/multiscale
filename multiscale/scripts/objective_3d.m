function value=objective_3d(x,a,v,lambda)
    [~,~,mx,mv]=size(a);
    s=0;
    recx=zeros(size(x));
    for i=1:mx
        for j=1:mv
            recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
        end
    end
    s=s+norm(x(:)-recx(:),2)^2;
    for j=1:mv
        vj=v(:,:,j);
        s=s+lambda*norm(vj(:),1);
    end
    value=s;
end