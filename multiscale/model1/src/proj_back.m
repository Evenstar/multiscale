function x=proj_back(u,p,s,filters,sl,el)
%
%u: coefficient at particular layer
%p: position of coefficients down to layer 1
%s: size of coefficients down to layer 1
%sl: start layer
%el: end layer

    function recx=inter_recx(s,a,v,mx,mv)
        %compute reconstructed input
        recx=zeros(s(1),s(2),mx);
        for i=1:mx
            for j=1:mv
                recx(:,:,i)=recx(:,:,i)+conv2(v(:,:,j),a(:,:,i,j),'valid');
            end
        end
    end
%compute from higher levels to lower levels
for l=el:-1:sl
    %filter for current unit
    a=filters{l};
    
    [r,~,mx,mv]=size(a);
    %recover sparse coefficients before max pooling
    u=rev_max_abs_pooling(u,p{l},s{l});
    %size of input for current unit
    xs=[size(u,1)-r+1,size(u,2)-r+1];
    %recover input for current unit
    u=inter_recx(xs,a,u,mx,mv);
end
x=u;
end