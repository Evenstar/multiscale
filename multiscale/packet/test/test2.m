dict=randn(6,6,4);
newdict=proj_uep_2d(dict,5000);
%%
A=reshape(newdict,[36,4]);
A=A';
aw_uep_2d_c(A)
%%
x=double(imread('../data/barbara.png'))/255;
A=orth(randn(4))/2;
st=wtfdec2(x,A,1,2);
recx=wtfrec2(st);
psnr(x,recx)

%%
%Test DB3
[L,H]=wfilters('db3');
a=[];
a(:,:,1)=L'*L;
a(:,:,2)=L'*H;
a(:,:,3)=H'*L;
a(:,:,4)=H'*H;
A=reshape(a,[36,4]);
A=A'/2;
aw_uep_2d_c(A)

x=double(imread('../data/barbara.png'))/255;
st=wtfdec2(x,A,2,2);
s1=0;
s2=0;
for i=1:2
    for j=1:4
        s1=s1+nnz(st.coef{i}{j});
    st.coef{i}{j}=st.coef{i}{j}.*(abs(st.coef{i}{j})>0.2);
    s2=s2+nnz(st.coef{i}{j});
    end
end
recimg=wtfrec2(st);
psnr(img,recimg)
s1/s2
recx=wtfrec2(st);
psnr(x,recx)