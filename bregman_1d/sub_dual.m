function [B_hat,C_hat]=sub_dual(x,A,B,C,D,P)
    [r,m]=size(A);
    V=zeros(length(x)+r-1,m);
    for i=1:m
        V(:,i)=conv(A(:,i),x);
    end
    B_hat=B+V-D;
    C_hat=C+A-P;
end