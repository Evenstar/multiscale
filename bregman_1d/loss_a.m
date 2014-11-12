function obj=loss_a(x,A,B,D)
    [~,m]=size(A);
    s=0;
    for i=1:m
        v=conv(A(:,i),x)-(D(:,i)-B(:,i));
        s=s+norm(v,'fro')^2;
    end
    obj=s;
end