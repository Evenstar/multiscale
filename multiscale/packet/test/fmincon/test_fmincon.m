y=double(imread('../../data/fingerprint.tif'))/255;
x=imresize(y,1/2,'cubic');
a=get_initial_guess(y,6,4,10000);
a=reshape(a',[6,6,4]);

[r,~,mv]=size(a);
for j=1:mv
    a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/2;
    a(:,:,j)=rot90(a(:,:,j),2);
end
%%
y=double(imread('../../data/fingerprint.tif'))/255;
x=imresize(y,1/2,'cubic');
[L,H]=wfilters('db3');
a(:,:,1)=L'*L;
a(:,:,2)=L'*H;
a(:,:,3)=H'*L;
a(:,:,4)=H'*H;
a=a/2;
%%
tic
a=fmincon_test(x,a,400);
toc

%%
y=double(imread('../../data/barbara.png'))/255;
A=transpose(reshape(a,[36,4]));
A=sortdict(A);
st=wtfdec2(y,A,2,1);
recy=wtfrec2(st);
psnr(y,recy)
%%
