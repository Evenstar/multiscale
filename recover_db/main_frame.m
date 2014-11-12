[l,h]=wfilters('db4');
B=[l;h];
N=100;
[c,s]=wavedec(randn(1,N),1,'db4');
len=length(c);
t=sprand(1,len,0.1);
x=waverec(t,s,'db4');
s=1000;
best=[];
for k=1:2
    k
A=orth(randn(6));
a0=A(1:2,:);
opt=fmincon_search_frame(B+rand(size(B))*1e-2,x,100);
H_opt=hamiltonian(opt,x);
H_db=hamiltonian(B,x);
if H_opt<s
    s=H_opt;
    best=opt;
end
end
hamiltonian(best,x)
hamiltonian(B,x)

