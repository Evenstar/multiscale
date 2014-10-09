function [newdict,E]=fmin_update_mid_dict(x,a,u,lambda,maxiter)
[r,~,mx,mv]=size(a);
    function [out,df]=obj(a)
        a=reshape(a,[r,r,mx,mv]);
        u=inter_mid_recv(x,a);
        rx=inter_mid_recx(a,u)-x;
        out=lambda*norm(rx(:),2)+norm(u(:),1);
        df=inter_df(x,a,u);
        df=df(:);
    end
obj(a)
options=optimset('Display','iter','maxiter',maxiter,'MaxFunEvals',20000000, ...
    'GradObj','Off');
newdict=fminunc(@obj,a(:),options);
newdict=reshape(newdict,[r,r,mx,mv]);
E=obj(newdict);
end

function [df,rx]=inter_df(x,a,u)
[r,~,mx,mv]=size(a);
df=zeros(size(a));
rx=inter_mid_recx(a,u);
rx=rx-x;
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=2*conv2(rot90(u(:,:,j),2),rx(:,:,i),'valid');
    end
end
end
