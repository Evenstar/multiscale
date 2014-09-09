function df=inter_df(x,a)
[r,~,mx,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end

rx=recx-x;
rv=zeros(size(v));
for j=1:mv
    for i=1:mx
        rv(:,:,j)=rv(:,:,j)+conv2(a(:,:,i,j),x(:,:,i));
    end
end

df1=zeros(size(a));
df2=zeros(size(a));
for i=1:mx
    for j=1:mv
        df1(:,:,i,j)=2*conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
    end
end

rs=zeros(size(v));
for j=1:mv
    for i=1:mx
        rs(:,:,j)=rs(:,:,j)+conv2(rot90(a(:,:,i,j),2),rx(:,:,i)); 
    end
end

for j=1:mv
    for i=1:mx
        df2(:,:,i,j)=2*conv2(rot90(rs(:,:,j),2),x(:,:,i),'valid');
    end
end
df=df1+df2;
end