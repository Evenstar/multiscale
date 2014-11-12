function [err,d]=awbft_1d_err(x,a,b,f)
    v=awbft_1d_dec(x,a,f);
    recx=awbft_1d_rec(v,b);
    err=norm(x(:)-recx(:),'fro');
    x=x./(norm(x,2));
    recx=recx./(norm(recx,2));
    d=dot(x,recx);
end