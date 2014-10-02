x=double(imread('../../data/barbara.png'))/255;
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
y=double(imread('../../data/barbara.png'))/255;
y=imresize(y,1/2);
psw=get_psnr(y,w,7);
I=2:20;
figure(1);
plot(I,psw(2:end),'-ob','LineWidth',1);hold on;
psa=get_psnr(y,a,7);
plot(I,psa(2:end),'-*r','LineWidth',1);
xlabel('Compression Ratio');
ylabel('PSNR')
grid on
legend('adaptive wavelet tight frame','wavelet tight frame generated from db3')
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 figure1.eps
close;
%%
