function recImg=mtfrec2(st)
L=st.L;
dict=st.dict;

for l=L:-1:1
    Dict=dict;
    for j=1:l-1
        Dict=doublefilter(Dict);
    end
    r=sqrt(size(Dict,2));
    if l>1
        imgSize=size(st.coef{l-1}{2});
    else
        imgSize=st.imgSize;
    end
    recImg=zeros(imgSize);
    coef=st.coef{l};
    for i=1:size(Dict,1)
        a=reshape(Dict(i,:),[r,r]);
        a=rot90(a,2);
        temp=conv2(coef{i},a,'valid');
        recImg=recImg+temp(1:imgSize(1),1:imgSize(2));
    end
    if l>1
        st.coef{l-1}{1}=recImg/r;
    end
end
recImg=recImg/r;
end