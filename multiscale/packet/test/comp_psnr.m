function PS=comp_psnr(x,a)
[r,~,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
v=inter_recv(x,a,v);
N=20;
E=zeros(1,N);
for i=1:N
    u=v.*(abs(v)>i/N);
    recx=inter_recx(x,a,u);
    PS(i)=psnr(x,recx);
end
end

