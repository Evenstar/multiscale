function recImg=mtfrec2_imp(struct)
imgSize=struct.imgSize;
coef=struct.coef;
dict=struct.dict;
f=struct.df;
r=sqrt(size(dict,2));
L=struct.L;

recImg=coef{L+1}{1};
for l=L:-1:1
    
    a=reshape(dict(1,:),[r,r]);
    temp=transpose(upsample(transpose(upsample(recImg,f)),f));
    recImg=conv2(temp,a,'valid');
    for i=2:size(dict,2)
        a=reshape(dict(i,:),[r,r]);
        temp=transpose(upsample(transpose(upsample(coef{l}{i},f)),f));
        temp=conv2(temp,a,'valid');
        recImg=recImg+temp;
    end
    if l>1
        [m,n]=size(coef{l-1}{2});
        recImg=recImg(1:m,1:n);
    else
        recImg=recImg(1:imgSize(1),1:imgSize(2));
    end
end
