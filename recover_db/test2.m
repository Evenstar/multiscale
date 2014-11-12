[l,h]=wfilters('db2');
B=[l;h];
N=1000;
[c,s]=wavedec(randn(1,N),1,'db2');
len=length(c);
t=sprand(1,len,0.1);
x=waverec(t,s,'db2');
%%
s=1000;
best=[];
for k=1:20
    k
A=orth(randn(4));
a0=A(1:2,:);
opt=fmincon_search(a0,x,1000);
H_opt=hamiltonian(opt,x);
H_db=hamiltonian(B,x);
if H_opt<s
    s=H_opt;
    best=opt;
end
end
hamiltonian(best,x)
H_db
%%
[~,~,B]=gen_coef_mat(best,1);
awbft_1d_err(x,fliplr(best),B,1)
%%
S=1000;
tic
M=1000000;
best=B;
for i=1:M
    A=orth(randn(4));
    A=A(1:2,:);
    if hamiltonian(A,x)<S
        S=hamiltonian(A,x);
        best=A;
    end
end
hamiltonian(best,x)
hamiltonian(B,x)
toc
%%
ObjectiveFunction = @(a) parameterized_objective(a,x);
A=orth(randn(4));
a0=B+randn(size(B))*0.1;
options=saoptimset('MaxFunEvals',1e5);
[best,fval] = simulannealbnd(ObjectiveFunction,a0,[],[],options);
hamiltonian(best,x)
hamiltonian(B,x)