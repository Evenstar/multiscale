function out=bregman_infeasibility_v(x,a,v)
    rv=v-inter_recv(x,a,v);
    out=norm(rv(:),1);
end