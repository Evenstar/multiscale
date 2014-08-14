function newdict=infer_dict_cur_frcg(x,v,opt,l)
%for first layer, call simpler solver directly.
if l==1
    v=rev_max_abs_pooling(v,opt.p{1},opt.s{1});
    newdict=inter_dict_frcg(x,v,opt.filter{1},opt.cg_iter(1));
    return;
end

a=opt.filter{l};
%algorithm operates on undownsampled coefficients.
v=rev_max_abs_pooling(v,opt.p{l},opt.s{l});
%compute gradient
df=inter_df(x,a,v,opt,l);
%initialize search direction
p=-df;
%iteration counter
k=0;

while k<opt.cg_iter(l)
    %compute stepsize
    alpha=inter_alpha(x,a,v,p,opt,l);
    %update dict
    a=a+alpha*p;
    %compute new gradient
    ndf=inter_df(x,a,v,opt,l);
    %compute beta
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %update search direction
    p=-ndf+beta*df;
    k=k+1;
    %check convergence
    ru=inter_recu(a,v);
    recx=inter_backward(ru,opt.p,opt.s,opt.filter,l-1);
    E=log10(norm(recx(:)-x(:),2));
end
newdict=a;

if E>3
    warning('Failed to converge');
end
end

%compute coefficient directly above current layer
function recu=inter_recu(a,v)
[r,~,mx,mv]=size(a);
recu=zeros(size(v,1)-r+1,size(v,2)-r+1,mx);
for i=1:mx
    for j=1:mv
        recu(:,:,i)=recu(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end

%compute gradient
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

%compute optimal stepsize
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