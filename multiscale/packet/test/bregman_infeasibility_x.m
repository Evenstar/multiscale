function out=bregman_infeasibility_x(x,a,v)
recx=inter_recx(x,a,inter_recv(x,a,v));
out=psnr(x,recx);
end