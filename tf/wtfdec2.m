function st=wtfdec2(img, dict, L, f)
    st.imgsize=size(img);
    st.dict=dict;
    st.coef=cell(L,1);
    st.L=L;
    st.df=f;
    %allow for m*r^2 filters.
    m=size(dict,1);
    r=sqrt(size(dict,2));
    
    curimg=img;
    for l=1:L
        for i=1:m
            a=reshape(dict(i,:),[r,r]);
            a=rot90(a,2);
            img_ext=wextend('2','sym',curimg,r-1);
            temp=conv2(img_ext,a,'valid')*f;
            st.coef{l}{i}=transpose(downsample(transpose(downsample(temp,f)),f));
        end
        curimg=st.coef{l}{1};
        if l<L
        st.coef{l}{1}=[];
        end
    end