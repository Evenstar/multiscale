function st=mtfdec2_imp(img,dict,L,f)
%
%The first element of dict must be low frequency filter,no check.
st.imgSize=size(img);
st.dict=dict;
st.coef=cell(L+1,1);
st.L=L;
st.df=f;
r=sqrt(size(dict,2));

st.coef{1}{1}=img;
for l=1:L
    img_ext=wextend('2','sym',st.coef{l}{1},r-1);
    a=reshape(dict(1,:),[r,r]);
    a=rot90(a,2);
    temp=conv2(img_ext,a,'valid')/r/f;
    st.coef{l+1}{1}=transpose(downsample(transpose(downsample(temp,f)),f));
    for i=2:size(dict,1)
        a=reshape(dict(i,:),[r,r]);
        a=rot90(a,2);
        temp=conv2(img_ext,a,'valid')/r/f;
        st.coef{l}{i}=transpose(downsample(transpose(downsample(temp,f)),f));
    end
    st.coef{l}{1}=[];
end

end