function [newdict,p]=fmin_inter_dict_sample(x,a,lambda,maxiter)
[r,~,mx,mv]=size(a);
    function out=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        v=inter_mid_recv(x,a);
        u=v;
        u(1:2:end,:,:)=0;
        u(:,1:2:end,:)=0;
        recx=inter_mid_recx(a,u);
        rx=x-recx;
        out=norm(v(:),1)+lambda*norm(rx(:),2);
    end

options=optimset('Display','iter','maxiter',maxiter,'MaxFunEvals',20000000, ...
    'Algorithm','Interior-Point','TolCon',1e-9);
obj(a)
newdict=fminunc(@obj,a(:),options);
newdict = reshape(newdict,[r,r,mx,mv]);
obj(newdict)
rx=x-inter_mid_recx(a,inter_mid_recv(x,a));
p=norm(rx(:),2);
end





