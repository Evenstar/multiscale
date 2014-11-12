function flag=check_biframe(a,b)
[m,r]=size(a);
s=sum(a(:).*b(:));
flag=max(abs(s)-1,0);
for k=1:r-1
    s=0;
    for l=1:m
        for i=1:r-k
            s=s+a(l,i)*b(l,i+k);
        end
    end
    flag=max(flag,abs(s));
    s=0;
    for l=1:m
        for i=1:r-k
            s=s+a(l,i+k)*b(l,i);
        end
    end
    flag=max(flag,abs(s));
end
end