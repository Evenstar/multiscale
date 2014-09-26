function st=mtfdec2(img, dict, L, boundary_condition)
%
%The first element of dict must be low frequency filter.

st.imgSize=size(img);
st.dict=dict;
st.coef=cell(L,1);
st.L=L;
r=sqrt(size(dict,2));



for l=1:L
    coef=cell(size(dict,1),1);
    if l==1
        img_ext=wextend('2',boundary_condition,img,r-1);
    else
        dict=doublefilter(dict);
        r=sqrt(size(dict,2));
        img_ext=wextend('2',boundary_condition,res,r-1);
        st.coef{l-1}{1}=[];
        clear res;
    end
    for i=1:size(dict,1)
        a=reshape(dict(i,:),[r,r]);
        coef{i}=conv2(img_ext,a,'valid')/r;
    end
    res=coef{1};
    st.coef{l}=coef;
end
end