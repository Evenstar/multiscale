function err=awbft_2d_err(x,a,b)
    v=awbft_2d_dec(x,a);
    recx=awbft_2d_rec(v,b);
    err=norm(x(:)-recx(:),'fro');
end