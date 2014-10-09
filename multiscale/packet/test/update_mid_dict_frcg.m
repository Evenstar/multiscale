function [newdict,E]=update_mid_dict_frcg(x,a,u,maxiter)
k=0;
[df,rx]=inter_df(x,a,u);
while k<maxiter
    a=a-1e-3*df/max(abs(df(:)));
    
    
    E(k+1)=log10(obj(x,a,u));
    %         [ndf,rx]=inter_df(x,a,u);
    %         if norm(df(:),2)<1e-9
    %             break;
    %         end
    %         beta=norm(ndf(:),2)^2/norm(df(:),2)^2;
    %         p=-ndf+beta*df;
    k=k+1;
    %     end
    newdict=a;

end
    E
end

function [df,rx]=inter_df(x,a,u)
[r,~,mx,mv]=size(a);
df=zeros(size(a));
rx=inter_mid_recx(a,u);
for i=1:mx
    for j=1:mv
        df(:,:,i,j)=2*conv2(rot90(u(:,:,j),2),rx(:,:,i),'valid');
    end
end
end

function alpha=inter_alpha(u,p,rx)
px=inter_mid_recx(p,u);
nrm=norm(px(:),2);
if nrm < 1e-9
    alpha=0;
end
alpha=-dot(rx(:),px(:))/norm(px(:),2)^2;
end

function out=obj(x,a,u)
rx=inter_mid_recx(a,u)-x;
out=norm(rx(:),2)^2;
end