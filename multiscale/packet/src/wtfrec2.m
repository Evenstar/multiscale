function img=wtfrec2(st)
imgsize=st.imgsize;
dict=st.dict;
L=st.L;
f=st.df;
m=size(dict,1);
r=sqrt(size(dict,2));
coef=st.coef;
img=[];
for l=L:-1:1
    if l>1
    [sr,sc]=size(coef{l-1}{2});
    else
       sr=imgsize(1);
       sc=imgsize(2);
    end
    img=zeros(sr,sc);
    for i=1:m
        a=reshape(dict(i,:),[r,r]);
        temp=transpose(upsample(transpose(upsample(coef{l}{i},f)),f));
        temp=conv2(temp,a,'valid')*f;
        img=img+temp(1:sr,1:sc);
    end
    if l>1
    coef{l-1}{1}=img;
    end
end
end