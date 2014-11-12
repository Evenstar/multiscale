%% Generate data x
%
[l,h]=wfilters('db3');
B=[l;h];
N=1000;
[c,s]=wavedec(randn(N,1),1,'db3');
len=length(c);
t=sprand(1,len,0.1);
x=waverec(t,s,'db3');
if size(x,1)==1
    x=x';
end
%% Initialize parameters
% DESCRIPTIVE TEXT
r=6;
m=3;
eta=1e2;
lambda=1e3;
A=orth(randn(r));
A=A(:,1:m);
D=zeros(length(x)+r-1,m);
B=zeros(size(D));
P=A;
C=zeros(size(A));
%% Check d step
% DESCRIPTIVE TEXT
D=sub_d(x,A,B,eta);
%% Check a step
% DESCRIPTIVE TEXT
A_hat=sub_a(x,A,B,C,D,P,eta,lambda,100)
%% Check p step
% DESCRIPTIVE TEXT
P_hat=sub_p(A,C)
%% Check dual step
% DESCRIPTIVE TEXT
[B,C]=sub_dual(x,A,B,C,D,P)
%% Check Hamiltonian
% DESCRIPTIVE TEXT
hamiltonian_l1(A,x)
hamiltonian_l1(A_hat,x)


%% Simulate a few steps
% DESCRIPTIVE TEXT
r=6;m=2;eta=50;lambda=500;
A=orth(randn(r)); A=A(:,1:m);
A=DB+randn(size(DB))*0.2;
A0=A;
D=zeros(length(x)+r-1,m);
B=zeros(size(D));
P=A;
C=zeros(size(A));
clear E
tic
for k=1:50
    A_old=A;
    for i=1:1
        D=sub_d(x,A,B,eta);
        A=sub_a(x,A,B,C,D,P,eta,lambda,10);
    end
    A=sub_a(x,A,B,C,D,P,eta,lambda,10);
    P=sub_p(A,C);
    [B,C]=sub_dual(x,A,B,C,D,P);
    E(k)=hamiltonian_l1(A,x);
    E(k)
end
toc
plot(1:length(E),E,'r*-');hold on;
plot(1:length(E),hamiltonian_l1(DB,x)*ones(1,length(E)),'k-');
%%
[l,h]=wfilters('db3');
DB=[l',h'];
hamiltonian_l1(DB,x)
hamiltonian_l1(A,x)


%%
A=orth(randn(r)); A=A(:,1:m);
D=zeros(length(x)+r-1,m);
B=zeros(size(D));
eta=1e3;
stepsize=1e-3;
for k=1:10000
    
    D=sub_d(x,A,B,eta);
    for l=1:3
        A=pgd_a(x,A,B,D,stepsize);
    end
    
    V=zeros(length(x)+r-1,m);
    for i=1:m
        V(:,i)=conv(A(:,i),x);
    end
    B=B+V-D;
    hamiltonian_l1(A,x)
end
%%
df=zeros(r,m);
for i=1:r
    for j=1:m
        h=zeros(r,m);
        h(i,j)=1e-8;
        df(i,j)=(loss_a(x,A+h,B,D)-loss_a(x,A,B,D))/1e-8;
    end
end
df

%%
F=@(a) norm(conv(a,x)-b,'fro')^2;
a=A(:,1);
df=zeros(6,1);
for i=1:6
    h=zeros(6,1);
    h(i)=1e-8;
    df(i)=(F(a+h)-F(a))/1e-8;
end
df
rx=conv(a,x)-b;
DF=2*conv(rx,flipud(x),'valid')














