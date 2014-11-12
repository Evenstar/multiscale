function recImg=tfrec2(struct)
%tfrec2 2D frame reconstruction.
%tfrec2 performs 2D reconstruction for images. 
imgSize=struct.imgSize;
coef=struct.coef;
dict=struct.dict;
f=struct.df;
r=sqrt(size(dict,2));

recImg=zeros(imgSize);

for i=1:size(dict,1)
    a=reshape(dict(i,:),[r,r]);
    temp=transpose(upsample(transpose(upsample(coef{i},f)),f));
    temp=conv2(temp,a,'valid');
    recImg=recImg+temp(1:imgSize(1),1:imgSize(2));
end

recImg=recImg;
end