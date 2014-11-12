function Dict=doublefilter(dict)
[m,n]=size(dict);
r=sqrt(n);
Dict=zeros(m,2*r*2*r);
for i=1:m
    a=reshape(dict(i,:),r,r);
    a=upsample(transpose(upsample(a,2)),2);
    Dict(i,:)=a(:)'*2;
end
end