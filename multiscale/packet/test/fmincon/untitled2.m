%% Test Compression
% DESCRIPTIVE TEXT

[L,H]=wfilters('db3');
w(:,:,1)=L'*L;
w(:,:,2)=L'*H;
w(:,:,3)=H'*L;
w(:,:,4)=H'*H;
w=w/2;
y=double(imread('../../data/fingerprint.tif'))/255;
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

%%
x=double(imread('../../data/fingerprint.tif'))/255;
x=imresize(x,1/4);
[L,H]=wfilters('db3');
w(:,:,1)=L'*L;
w(:,:,2)=L'*H;
w(:,:,3)=H'*L;
w(:,:,4)=H'*H;
w=w/2;
%to save time, load pre-trained fitler. It is the same as executing the
%next few commented lines.
load('bb.mat')
%a=fmincon_test_1(x,w,4000);
%a=fmincon_test_2(x,a,200);
%%
y=double(imread('../../data/fingerprint.tif'))/255;
I=2:20;
psa=get_psnr(y,a,7);
psw=get_psnr(y,w,7);
figure(1);
plot(I,psa(2:end),'-*r','LineWidth',1);hold on;
plot(I,psw(2:end),'-ob','LineWidth',1);
xlabel('Compression Ratio');
ylabel('PSNR')
grid on
legend('wavelet tight frame generated from db3','adaptive wavelet tight frame')
set(gcf, 'PaperPositionMode', 'auto');

print -depsc2 figure1.eps
close;
%%
