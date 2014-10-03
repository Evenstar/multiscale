y=double(imread('../../data/fingerprint.tif'))/255;
x=imresize(1-y,1/4,'cubic');
a=get_initial_guess(y,6,4,10000);
a=reshape(a',[6,6,4]);

[r,~,mv]=size(a);
for j=1:mv
    a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/2;
end
%%
x=double(Images(:,:,5))/255;
x=imresize(x,1/4);
[L,H]=wfilters('db3');
a(:,:,1)=L'*L;
a(:,:,2)=L'*H;
a(:,:,3)=H'*L;
a(:,:,4)=H'*H;
a=a/2;
%%
tic
a=fmincon_test(x,a,1000);
save('dd','a')
toc

%%
y=x;
A=transpose(reshape(a,[36,4]));
A=sortdict(A);
st=wtfdec2(y,A,2,1);
recy=wtfrec2(st);
psnr(y,recy)
%%
x=double(Images(:,:,5))/255;
[L,H]=wfilters('db3');
w(:,:,1)=L'*L;
w(:,:,2)=L'*H;
w(:,:,3)=H'*L;
w(:,:,4)=H'*H;
w=w/2;
psw=get_psnr(x,w,5);
I=2:20;
figure(1);
plot(I,psw(2:end),'-ob','LineWidth',1);hold on;
psa=get_psnr(x,a,5);
plot(I,psa(2:end),'-*r','LineWidth',1);
xlabel('Compression Ratio');
ylabel('PSNR')
grid on
legend('wavelet tight frame generated from db3','adaptive wavelet tight frame')
set(gcf, 'PaperPositionMode', 'auto');
%%
print -depsc2 figure2.eps
close;