function [newdict]=bregman_update_dict_frcg(x,a,v,b,d,tau,eta,maxiter)
%this program updates the filters by solving the following program using
%FRCG method:
%min F(a):=\tau\sum_j{\|a_j(-\cdot)*x+b_j-v_j\|_2^2+\eta\|x-\sum_j a_j*v_j-d\|_2^2}

%initialization
k=0;
[df,rv,rx]=inter_df(x,a,v,b,d,tau,eta);
p=-df;

while k<maxiter
    %compute optimal stepsize
    alpha=inter_alpha(x,v,p,tau,eta,rv,rx);
    %update a in direction p
    a=a+alpha*p;
    %record value of loss function, for debug only
    %L(k+1)=log10(loss(x,a,v,b,d,tau,eta));
    
    %compute the new gradient
    [ndf,rv,rx]=inter_df(x,a,v,b,d,tau,eta);
    %compute beta
    beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %generate a new search direction
    p=-ndf+beta*df;
    k=k+1;  
end
newdict=a;
end

function recv=inter_recv(x,a,v)
recv=zeros(size(v));
[~,~,mv]=size(a);
for j=1:mv
    recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
end
end

function recx=inter_recx(x,a,v)
recx=zeros(size(x));
[~,~,mv]=size(a);
for j=1:mv
    recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
end
end

function out=loss(x,a,v,b,d,tau,eta)
recv=inter_recv(x,a,v);
rv=recv+b-v;
E1=norm(rv(:),2)^2;
recx=inter_recx(x,a,v);
rx=recx+d-x;
E2=norm(rx(:),2)^2;
out=tau*E1+eta*E2;
end

function [df,rv,rx]=inter_df(x,a,v,b,d,tau,eta)
[~,~,mv]=size(a);
df=zeros(size(a));
rv=inter_recv(x,a,v)+b-v;
rx=inter_recx(x,a,v)+d-x;
for j=1:mv
    df(:,:,j)=2*tau*conv2(rot90(rv(:,:,j),2),x,'valid');
    df(:,:,j)=df(:,:,j)+2*eta*conv2(rot90(v(:,:,j),2),rx,'valid');
end
end

function alpha=inter_alpha(x,v,p,tau,eta,rv,rx)
pv=inter_recv(x,p,v);
px=inter_recx(x,p,v);
sa=tau*dot(pv(:),rv(:))+eta*dot(px(:),rx(:));
sb=tau*norm(pv(:),2)^2+eta*norm(px(:),2)^2;
alpha=-sa/sb;
end
