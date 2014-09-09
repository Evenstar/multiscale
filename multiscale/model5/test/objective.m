function res=objective(x,v,dict,lambda)
recx=zeros(size(x));
m=size(dict,1);
r=sqrt(size(dict,2));
for i=1:m
  a=reshape(dict(i,:),[r,r]);
  recx=recx+conv2(v(:,:,i),a,'valid');
end
rx=recx-x;
res=norm(rx,2)^2+lambda*norm(v(:),1);
end