function [A_hat]=pgd_a(x,A,B,D,lambda)
    [~,m]=size(A);
    for i=1:m
        a=A(:,i);
        rx=conv(a,x)-(D(:,i)-B(:,i));
        df=2*conv(rx,flipud(x),'valid');
        A(:,i)=a-lambda*df;
    end
    [U,D,V]=svd(A);
    A_hat=U*eye(size(U,1),size(V,1))*V';
end