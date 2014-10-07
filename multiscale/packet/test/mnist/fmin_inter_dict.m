function newdict=fmin_inter_dict(x,a,v,lambda,maxiter)
[r,~,mx,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        v=inter_mid_recv(x,a,v);
        u=v;
        u(1:2:end,:,:)=0;
        u(:,1:2:end,:)=0;
        recx=inter_mid_recx(x,a,u);
        rx=x-recx;
        out=norm(v(:),1)+lambda*norm(rx(:),2);
    end
options=optimset('Display','iter','maxiter',maxiter,'MaxFunEvals',20000000, ...
    'Algorithm','Interior-Point','TolCon',1e-9);
%newdict = fmincon(@obj,a(:),[],[],[],[],[],[],@nonlcon,options);
obj(a)
newdict=fminunc(@obj,a(:),options);
newdict = reshape(newdict,[r,r,mx,mv]);
obj(newdict)
end

function v=inter_mid_recv(x,a,v)
[r,~,mx,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for i=1:mx
    for j=1:mv
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
end

function recx=inter_mid_recx(x,a,v)
[r,~,mx,mv]=size(a);
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
    end
end
end

