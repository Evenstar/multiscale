function H=hamiltonian_l1(A,x)
    H=0;
    [r,m]=size(A);
    V=zeros(length(x)+r-1,m);
    for i=1:m
        V(:,i)=conv(A(:,i),x);
        H=H+sum(abs(V(:,i)));
    end
end