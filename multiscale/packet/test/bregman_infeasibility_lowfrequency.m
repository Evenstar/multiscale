function out=bregman_infeasibility_lowfrequency(a)
    [~,~,mv]=size(a);
    E=zeros(1,mv);
    for j=1:mv
        E(j)=sum(sum(a(:,:,j)));
    end
    E=sort(abs(E),'descend');
    U=zeros(size(E));
    U(1)=1;
    out=max(abs(E-U));
end