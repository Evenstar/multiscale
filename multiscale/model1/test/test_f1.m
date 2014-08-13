function out=test_f1(dict)
m=size(dict,1);
r=sqrt(size(dict,2));
img=evalin('base','img');
coef=evalin('base','coef');
recx=zeros(size(img));
    for i=1:m

        a=reshape(dict(i,:),[r,r]);
        recx=recx+conv2(coef(:,:,i),a,'valid');
    end
out=norm(recx-img,2);
end