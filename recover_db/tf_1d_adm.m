function W=tf_1d_adm(A,X,maxiter,lambda,Y)
W=fliplr(A);
for i=1:maxiter
    H=soft(W*X,lambda);
    [U,~,Q]=svd(H*X');
    W=U*eye(size(U,1),size(Q,1))*Q';
end
W=fliplr(W);
end