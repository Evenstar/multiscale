function newdict=test_numeric(x,a,v,maxiter)
[r,~,mx,mv]=size(a);
    function obj=objective(a)
        a=reshape(a,[r,r,mx,mv]);
        recv=inter_recv(x,a,v);
        obj=norm(recv(:)-v(:),2)^2;
    end
    function obj=objective_x(a)
        a=reshape(a,[r,r,mx,mv]);
        recx=inter_recx(x,a,v);
        obj=norm(recx(:)-x(:),2)^2;
    end
options=optimset('maxiter',maxiter);
newdict=fminunc(@objective_x,a(:),options);
E=log10(objective(newdict))/2
end

function recv=inter_recv(x,a,v)
[~,~,mx,mv]=size(a);
recv=zeros(size(v));
for j=1:mv
    for i=1:mx
        recv(:,:,j)=recv(:,:,j)+conv2(a(:,:,i,j),x(:,:,i));
    end
end
end

function recx=inter_recx(x,a,v)
%compute reconstructed input
[~,~,mx,mv]=size(a);
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end