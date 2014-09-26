function [newdict]=bregman_update_dict_gd(x,a,v,b,d,eta,maxiter)
[r,~,mv]=size(a);
    function recv=inter_recv(a,x)
        recv=zeros(size(v));
        for j=1:mv
            recv(:,:,j)=conv2(rot90(a(:,:,j),2),x);
        end
    end

    function recx=inter_recx(a,v)
        recx=zeros(size(x));
        for j=1:mv
            recx=recx+conv2(v(:,:,j),a(:,:,j),'valid');
        end
    end

    function out=loss(dict)
        recv=inter_recv(dict,x);
        rv=v-recv-b;
        E1=norm(rv(:),2)^2;
        recx=inter_recx(dict,v);
        rx=x-recx-d;
        E2=norm(rx(:),2)^2;
        out=E1+eta*E2;
    end

    function df=inter_df(dict)
        df=zeros(size(dict));
        rv=inter_recv(dict,x)+b-v;
        rx=inter_recx(dict,v)+d-x;
        for j=1:mv
            df(:,:,j)=2*conv2(rv(:,:,j),rot90(x,2),'valid');
            df(:,:,j)=df(:,:,j)+2*eta*conv2(rot90(v(:,:,j),2),rx,'valid');
        end
    end

%test numerical derivative
% h=1e-8;
% D=zeros(size(a));
% for i=1:r
%     for l=1:r
%         for k=1:mv
%         E=a;
%         F=a;
%         E(i,l,k)=E(i,l,k)+h;
%         F(i,l,k)=F(i,l,k)-h;
%         D(i,l,k)=(loss(E)-loss(F))/2/h;
%         end
%     end
% end

k=0;
while k<maxiter
    LOSS=log10(loss(a))
    df=inter_df(a);
    df=df/max(abs(df(:)));
    a=a-1e-3/sqrt(k+1)*df;
    k=k+1;
end
end