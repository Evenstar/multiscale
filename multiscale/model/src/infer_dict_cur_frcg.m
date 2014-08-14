function newdict=infer_dict_cur_frcg(x,v,opt,l)
if l==1
    v=rev_max_abs_pooling(v,opt.p{1},opt.s{1});
    newdict=inter_dict_frcg(x,v,opt.filter{1},opt.cgiter(1));
    return;
end

a=opt.filter{l};
v=rev_max_abs_pooling(v,opt.p{l},opt.s{l});
df=inter_df(x,a,v,opt,l);
p=-df;
k=0;
while k<opt.cgiter(l)
    alpha=inter_alpha(x,a,v,p,opt,l);
    a=a+alpha*p;
    ndf=inter_df(x,a,v,opt,l);
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %update search direction
    p=-ndf+beta*df;
    k=k+1;   
    ru=inter_recu(a,v);
    recx=inter_backward(ru,opt.p,opt.s,opt.filter,l-1);
    E=log10(norm(recx(:)-x(:),2))   
end
newdict=a;
end



function v=inter_pooling_fixed(u,p,s,shape)
m=zeros(s);
m(p)=1;
u=u.*m;
v=max_abs_pooling(u,shape);
end

function v=inter_forward(x,filter,p,l)
v=x;
for k=1:l
    a=filter{k};
    [r,~,mx,mv]=size(a);
    u=zeros(size(v,1)+r-1,size(v,2)+r-1,mv);
    for j=1:mv
        for i=1:mx
            u(:,:,j)=u(:,:,j)+conv2(rot90(a(:,:,i,j),2),v(:,:,i));
        end
    end
    v=inter_pooling_fixed(u,p{k},size(u),[2,2]);
end
end

function x=inter_backward(v,p,s,filter,l)
x=v;
for k=l:-1:1
    v=rev_max_abs_pooling(x,p{k},s{k});
    a=filter{k};
    [r,~,mx,mv]=size(a);
    x=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
    for i=1:mx
        for j=1:mv
            x(:,:,i)=x(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
        end
    end
end
end

function recu=inter_recu(a,v)
[r,~,mx,mv]=size(a);
recu=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
for i=1:mx
    for j=1:mv
        recu(:,:,i)=recu(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end

function df=inter_df(x,a,v,opt,l)
[~,~,mx,mv]=size(a);
ru=inter_recu(a,v);
recx=inter_backward(ru,opt.p,opt.s,opt.filter,l-1);
rx=x-recx;
u=inter_forward(rx,opt.filter,opt.p,l-1);
df=zeros(size(a));
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=conv2(rot90(v(:,:,j),2),u(:,:,i),'valid');
    end
end
end

function alpha=inter_alpha(x,a,v,p,opt,l)
ru=inter_recu(a,v);
recx=inter_backward(ru,opt.p,opt.s,opt.filter,l-1);
rx=x-recx;

ru=inter_recu(p,v);
rp=inter_backward(ru,opt.p,opt.s,opt.filter,l-1);

sa=dot(rx(:),rp(:));
sb=norm(rp(:),2)^2;
alpha=sa/sb;

end




