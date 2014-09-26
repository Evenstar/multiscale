x=double(imread('../data/barbara.png'))/255;
load('a.mat');
[r,~,m]=size(a);
a=transpose(reshape(a,[r*r,m]));
a=sortdict(a);
st=wtfdec2(x,a,2,2);
recx=wtfrec2(st);
psnr(x,recx)
%%
for i=1:m
    st.coef{1}{i}=st.coef{1}{i}.*(abs(st.coef{1}{i})>0.0);
end
recx=wtfrec2(st);
psnr(x,recx)

%%
%compression with Haar wavelets
ratio=10;
[C,S]=wavedec2(x,2,'haar');
[~,I]=sort(abs(C(:)),'descend');
id=floor(nnz(C(:))/ratio);
mid=abs(C(I(id)))
C=C.*(abs(C)>mid);
y=waverec2(C,S,'haar');
psnr(x,y)