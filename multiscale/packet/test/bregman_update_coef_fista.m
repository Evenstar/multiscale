function [coef,E]=bregman_update_coef_fista(x,a,v,b,d,tau,eta,L,maxiter)
%this program computes the minimizer of the following minimization problem
%using FISTA algorithm:
%min_v \sum_j \|v_j\|_1+\tau\sum_j
%\|a_j(-\cdot)*x+b_j-v_j\|_2^2+\eta\|x-\sum_j a_j*v_j-d\|_2^2

k=0;
u=v;
t=ones(1,maxiter);
while k<maxiter
    k=k+1;
    E(k)=log10(obj(x,a,v,b,d,tau,eta));
    
    %compute gradient of f
    df=inter_df(x,a,u,b,d,tau,eta);
    vold=v;
    %update v, gradient step
    v=v-1/L*df;
    %update v, thresholding step
    v=soft(v,1/L);
    t(k+1)=1/2*(1+sqrt(1+4*t(k)^2));
    u=v+(t(k)-1)/t(k+1)*(v-vold);
end
coef=v;
end





function df=inter_df(x,a,v,b,d,tau,eta)
[~,~,mv]=size(a);
rv=v-b-inter_recv(x,a,v);
rx=inter_recx(x,a,v)-x+d;
df=zeros(size(v));
for j=1:mv
    df(:,:,j)=2*tau*rv(:,:,j);
    df(:,:,j)=df(:,:,j)+2*eta*conv2(rot90(a(:,:,j),2),rx);
end
end

function out=obj(x,a,v,b,d,tau,eta)
rv=v-b-inter_recv(x,a,v);
rx=inter_recx(x,a,v)-x+d;
out=norm(v(:),1)+tau*norm(rv(:),2)^2+eta*norm(rx(:),2)^2;
end