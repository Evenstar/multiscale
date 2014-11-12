function P_hat=sub_p(A,C)
[U,~,V]=svd(A+C);
P_hat=U*eye(size(U,1),size(V,1))*V';
end