%% Test Compression
% DESCRIPTIVE TEXT

[L,H]=wfilters('db3');
w(:,:,1)=L'*L;
w(:,:,2)=L'*H;
w(:,:,3)=H'*L;
w(:,:,4)=H'*H;
w=w/2;
y=double(imread('../../data/barbara.png'))/255;
y=imresize(y,1/2,'cubic');
psw=get_psnr(x,w,7);
plot(psw,'b');hold on;
psa=get_psnr(x,a,7);
plot(psa,'r');hold on;

%%
[r,~,mv]=size(a);
A=reshape(a,[r*r,mv]);
A=A';
A=sortdict(A);
st=wtfdec2(x,A,3,1);
recx=wtfrec2(st);
for i=1:3
    for j=1:4
        st.coef{i}{j}=st.coef{i}{j}.*(abs(st.coef{i}{j})>0.2);
    end
end
recx=wtfrec2(st);
imdisp(recx)