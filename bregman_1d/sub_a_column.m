function a_hat=sub_a_column(x,a,b,c,eta,lambda,maxiter)
% F(a)=eta*|a*x-b|^2+lambda*|a-c|^2
    function [e,df]=obj(a)
        v=conv(a,x);
        e=eta*norm(v-b,'fro')^2+lambda*norm(a-c,'fro')^2;
        df=2*eta*conv(v-b,flipud(x),'valid')+2*lambda*(a-c);
    end
options=optimset('Display','off','maxiter',maxiter,'MaxFunEvals',20000000, ...
    'GradObj','on');
a_hat=fminunc(@obj,a,options);
end