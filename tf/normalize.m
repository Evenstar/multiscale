function [NX,A]=normalize(X)
A=sqrt(sum(X.^2)+1e-8);
NX=X./repmat(A,[size(X,1),1]);
end
