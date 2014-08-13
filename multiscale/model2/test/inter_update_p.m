function [v,newp,news]=inter_update_p(x,p,s,filter,l)
v=inter_forward(x,filter,p,l-1);
a=filter{l};
[r,~,mx,mv]=size(a);
u=zeros(size(v,1)+r-1,size(v,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        u(:,:,j)=u(:,:,j)+conv2(rot90(a(:,:,i,j),2),v(:,:,i));
    end
end
news=s;
news{l}=size(u);
u=soft(u,1e-4);
[v,q]=max_abs_pooling(u,[2,2]);
newp=p;
newp{l}=q;
end