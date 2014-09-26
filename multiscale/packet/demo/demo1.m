%This is a simple demo that generates 4 filters of support 6x6 using a
%single image. Initial value is produced by another approximation program.
x=double(imread('../data/barbara.png'))/255;
%x=imresize(x,1/4);
%load pre-trained initial value.
a=get_initial_guess(x,6,4,5000)/4;
a=reshape(a',[6,6,4]);
%a=(randn([5,5,4]))/4;
[r,~,mv]=size(a);
%set value of lambda.
lambda=10^2;
%call traning program
[a,v,rx,obje]=func_demo1(x,a,500,lambda);

%display filters
for i=1:4
    subplot(2,2,i);
    imshow(a(:,:,i),[]);
end

%check element sum of each filter
E=zeros(1,mv);
for j=1:mv
    E(j)=sum(sum(a(:,:,j)));
end
E

recx=zeros(size(x));
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
psnr(x,recx)
log10(norm(v(:),1))
%%
img=double(imread('../data/barbara.png'))/255;
dict=reshape(a,[36,4]);
dict=dict'/2;
dict=sortdict(dict);
st=wtfdec2(img,dict,2,2);
recimg=wtfrec2(st);
psnr(img,recimg)


%%
img=double(imread('../data/barbara.png'))/255;
L=4;
st=wtfdec2(img,dict,L,2);
s1=0;
s2=0;
for i=1:L
    for j=1:4
        s1=s1+nnz(st.coef{i}{j});
    st.coef{i}{j}=st.coef{i}{j}.*(abs(st.coef{i}{j})>0.2);
    s2=s2+nnz(st.coef{i}{j});
    end
end
recimg=wtfrec2(st);
psnr(img,recimg)
s1/s2













































