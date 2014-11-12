function D=sub_d(x,A,B,eta)
    D=zeros(size(B));
    [~,m]=size(A);
    for i=1:m
        a=A(:,i);
        D(:,i)=conv(a,x)+B(:,i);
        D(:,i)=soft(D(:,i),1/eta);
    end
end