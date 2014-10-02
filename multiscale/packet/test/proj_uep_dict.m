function pdict=proj_uep_dict(x,a,v,maxiter)

x=randn(size(x));
[r,~,mv]=size(a);
for k=1:maxiter
    df=inter_df(x,a,v);
    a=a-1e-3*1/sqrt(k)*df;
    for j=1:mv
       a(:,:,j)=a(:,:,j)/norm(a(:,:,j),'fro')/sqrt(mv);
    end
end

function df=inter_df(x,a,v)
df=zeros(size(a));
v=inter_recv(x,a,v);
rx=inter_recx(x,a,v)-x;
u=zeros(size(v));
for j=1:mv
    u(:,:,j)=conv2(a(:,:,j),x);
end
for j=1:mv
    df(:,:,j)=2*conv2(rot90(v(:,:,j),2),rx,'valid');
    df(:,:,j)=df(:,:,j)+2*conv2(u(:,:,j),rot90(rx,2),'valid');
end
df=df/norm(rx(:),'fro');
end


function out=obj(a)
a=reshape(a,[r,r,mv]);
v=inter_recv(x,a,v);
rx=inter_recx(x,a,v)-x;
out=norm(rx(:),2);
end

% D=zeros(size(a));
% h=1e-8;
% for i=1:5
%     for l=1:5
%         for k=1:2
%             E=a;
%             E(i,l,k)=E(i,l,k)+h;
%             D(i,l,k)=(obj(E)-obj(a))/h;
%         end
%     end
% end
% df=inter_df(x,a,v)
% D

 %options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
 %pdict=fminunc(@obj,a(:),options);
 %pdict=reshape(pdict,[r,r,mv]);
pdict=a;
obj(pdict)
end