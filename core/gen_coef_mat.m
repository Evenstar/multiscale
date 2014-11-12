function [A,f,b]=gen_coef_mat(a,M)
[m,r]=size(a);
A=[];
f=[];
t=1;
%build matrix
for gamma=0:M-1
    for k=-r+1:r-1
        T=zeros(1,m*r);
        for n=0:ceil((r-gamma)/M)
            if 1<=M*n+gamma && M*n+gamma<=r && 1<=M*n+gamma+k && M*n+gamma+k<=r
                for l=1:m
                    T((l-1)*r+M*n+gamma)=a(l,M*n+gamma+k);
                end
            end
            
        end
        if norm(T)>1e-8
            A=[A;T];
            if k==0
                f=[f;1];
            else
                f=[f;0];
            end
        end
        t=t+1;
    end
end
b=A\f;
err=norm(A*b-f,1);
if abs(err)>1e-4
    warning('only L_2 solution found');
end
b=transpose(reshape(b,[r,m]));
end