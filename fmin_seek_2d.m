function biframe=fmin_seek_2d(x,a,b,maxiter)
[~,r,m]=size(a);
v=awbft_2d_dec(x,a);
    function out=obj(b)
        b=reshape(b,[r,r,m]);
        recx=awbft_2d_rec(v,b);
        out=norm(x(:)-recx(:),'fro');
    end
obj(b)
options=optimset('maxiter',maxiter,'MaxFunEval',2000000, ...
    'TolX',1e-9);
biframe=fminsearch(@obj,b(:),options);
obj(biframe)
biframe=reshape(biframe,[r,r,m]);
end