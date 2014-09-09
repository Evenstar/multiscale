function df=inter_df2(x,a)
[r,~,mx,mv]=size(a);
sizev=[size(x,1)+r-1,size(x,2)+r-1,mv];
v=inter_v(sizev,a,x);
rx=inter_recx(size(x),a,v)-x;
df1=zeros(size(a));
df2=zeros(size(a));

for i=1:mx
    for j=1:mv
        df1(:,:,i,j)=2*conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
    end
end

rs=inter_v(sizev,a,rx);
for j=1:mv
    for i=1:mx
        df2(:,:,i,j)=2*conv2(rot90(rs(:,:,j),2),x(:,:,i),'valid');
    end
end
df=df1+df2;

end

function recx=inter_recx(sizex,a,v)
[~,~,mx,mv]=size(a);
recx=zeros(sizex);
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end

function v=inter_v(sizev,a,x)
[~,~,mx,mv]=size(a);
v=zeros(sizev);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
end