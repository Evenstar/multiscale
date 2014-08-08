function x=project_back(v,a)
    [r,~,mx,mv]=size(a);
    x=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
    for i=1:mx
        for j=1:mv
            x(:,:,i)=x(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
        end
    end
end