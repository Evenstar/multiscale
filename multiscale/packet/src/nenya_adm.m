function [W,H]=nenya_adm(X,opts)
numAtoms=opts.numAtoms;
lambda=opts.lambda;
maxIter=opts.maxIter;
[m,n]=size(X);
W=randn(numAtoms,m);
H=zeros(n,numAtoms);

for i=1:maxIter
    H=soft(W*X,1/lambda);
    [U,~,V]=svd(X*H');
    W=V*eye(size(V,1),size(U,1))*U';    
end

end

function Y=soft(A,a)
Y=(A-a).*(A>a)+(A+a).*(A<-a);
end


