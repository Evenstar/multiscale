function opt=fmincon_search_orthogonal(a,x,maxiter)
    [m,r]=size(a);
    if m~=2
        error('m must be 2');
    end
    function e=obj(a)
        a=reshape(a,[2,r]);
        e=hamiltonian(a,x);
    end
    
    function [c,ceq]=nonlcon(a)
        a=reshape(a,[2,r]);
        ceq=[norm(a(1,:))-1;
             norm(a(2,:))-1;
             a(1,:)*a(2,:)'];
         c=[];
    end
options=optimset('Display','off','maxiter',maxiter,'MaxFunEvals',2000000, ...
 'TolCon',1e-4);
opt=fmincon(@obj,a,[],[],[],[],[],[],@nonlcon,options);
opt=reshape(opt,[2,r]);
end