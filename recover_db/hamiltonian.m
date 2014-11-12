function s=hamiltonian(a,x)
    [m,~]=size(a);
    s=0;
    for i=1:m
        v=conv(a(i,:),x);
        s=s+sum(abs(v));
    end
    
end