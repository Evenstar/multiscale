function biframe=fmin_seek(x,a,b,f,maxiter)
[m,r]=size(a);
v=awbft_1d_dec(x,a,f);
    function out=obj(b)
        b=reshape(b,[m,r]);
        recx=awbft_1d_rec(v,b);
        out=norm(x(:)-recx(:),'fro');
    end
obj(b)
options=optimset('maxiter',maxiter,'MaxFunEval',2000000, ...
    'TolX',1e-9);
biframe=fminsearch(@obj,b(:),options);
obj(biframe)
biframe=reshape(biframe,[m,r]);
end