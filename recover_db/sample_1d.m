function X=sample_1d(x,N,r)
if size(x,1)~=1 && size(x,2)~=1
    error('x must be a vector');
end
if size(x,1)==1
    x=x';
end
X=zeros(r,N);
m=length(x);
for k=1:N
    id=randi(m-r);
    X(:,k)=x(id:id+r-1);
end
end