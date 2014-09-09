function [newdict,recx]=inter_uep_gd(x,a,v,eta,L,maxiter)
[r,~,mx,mv]=size(a);
v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
for j=1:mv
    for i=1:mx
        v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end


for k=1:maxiter
    v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
    for j=1:mv
        for i=1:mx
            v(:,:,j)=v(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
        end
        v(:,:,j)=soft(v(:,:,j),1/30);
    end
    
    a=a-inter_dfa(x,a,v,eta)*L;
    recx=inter_recx(x,a,v);
    rx=recx-x;
    rv=inter_recv(v,a,x)-v;
    E=norm(rx(:),2)^2+eta*norm(rv(:),2)^2;
    log10(E)
end
newdict=a;
end

function recv=inter_recv(v,a,x)
[~,~,mx,mv]=size(a);
recv=zeros(size(v));
for j=1:mv
    for i=1:mx
        recv(:,:,j)=recv(:,:,j)+conv2(rot90(a(:,:,i,j),2),x(:,:,i));
    end
end
end

function recx=inter_recx(x,a,u)
[~,~,mx,mv]=size(a);
recx=zeros(size(x));
for i=1:mx
    for j=1:mv
        recx(:,:,i)=recx(:,:,i)+conv2(u(:,:,j),a(:,:,i,j),'valid');
    end
end
end

function dfv=inter_dfv(x,a,v,eta)
[r,~,mx,mv]=size(a);
dfv=zeros(size(v));
rx=inter_recx(x,a,v)-x;
rv=v-inter_recv(v,a,x);
for j=1:mv
    for i=1:mx
        dfv(:,:,j)=dfv(:,:,j)+2*conv2(rot90(a(:,:,i,j),2),rx(:,:,i));
    end
    dfv(:,:,j)=dfv(:,:,j)+2*eta*rv(:,:,j);
end
end

function dfa=inter_dfa(x,a,v,eta)
[r,~,mx,mv]=size(a);
dfa=zeros(size(a));
rx=inter_recx(x,a,v)-x;
rv=inter_recv(v,a,x)-v;
for i=1:mx
    for j=1:mv
        dfa(:,:,i,j)=dfa(:,:,i,j)+2*conv2(rot90(v(:,:,j),2),rx(:,:,i),'valid');
        dfa(:,:,i,j)=dfa(:,:,i,j)+2*eta*conv2(rv(:,:,j),x(:,:,i),'valid');
    end
end
end
