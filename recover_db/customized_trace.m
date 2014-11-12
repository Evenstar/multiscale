function tr=customized_trace(a)
[m,r]=size(a);
if m~=2
    error('m must be 2');
end
A=a'*a;
tr=zeros(r,1);
for i=0:r-1
    tr(i+1)=sum(diag(A,i));
end
end