function x=proj_back(u,p,filters,sl,el)
    function recx=inter_recx(s,a,v,mx,mv)
        %compute reconstructed input
        recx=zeros(s(1),s(2),mx);
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
            end
        end
    end
    function u=up_sample(v,p,scalar)
        u=zeros(size(v,1)*scalar,size(v,2)*scalar,size(v,3));
        u(p)=v;
    end
for l=el:-1:sl
    a=filters{l};
    [r,~,mx,mv]=size(a);
    u=up_sample(u,p{l},2);
    xs=[size(u,1)-r+1,size(u,2)-r+1];
    u=inter_recx(xs,a,u,mx,mv);     
end
x=u;
end