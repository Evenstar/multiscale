function A_hat=sub_a(x,A,B,C,D,P,eta,lambda,maxiter)
[r,m]=size(A);
A_hat=zeros(r,m);
for i=1:m
    A_hat(:,i)=sub_a_column(x,A(:,i),D(:,i)-B(:,i),P(:,i)-C(:,i),eta,lambda,maxiter);
end
end