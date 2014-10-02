function PS=get_psnr(x,a,L)
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
[seq,~]=sort(abs(coef));
for k=2:20
    discard_prop=(k-1)/k;
    N=length(coef);
    
    mid=seq(floor(discard_prop*N)+1);
    
    rst=st;
    for i=1:L
        for j=1:mv
            rst.coef{i}{j}=st.coef{i}{j}.*(abs(st.coef{i}{j}>mid));
        end
    end
    recx=wtfrec2(rst);
    PS(k)=psnr(x,recx);
end
end