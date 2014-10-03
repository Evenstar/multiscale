function PS=get_psnr_noisy(x,cx,a,L)
PS=zeros(1,20);
[r,~,mv]=size(a);
A=reshape(a,[r*r,mv]);
A=A';
A=sortdict(A);
st=wtfdec2(x,A,L,1);
coef=[];
for i=1:L
    for j=1:mv
        temp=st.coef{i}{j};
        coef=[coef;temp(:)];
    end
end
for k=1:20
    mid=(k-1)/200;
    rst=st;
    for i=1:L
        for j=1:mv
            rst.coef{i}{j}=soft(rst.coef{i}{j},mid);
        end
    end
    recx=wtfrec2(rst);
    PS(k)=psnr(cx,recx);
end
end