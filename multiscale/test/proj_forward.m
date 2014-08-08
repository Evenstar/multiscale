function [v,p]=proj_forward(x,filters,L,lambda,maxiter)
    levels=length(filters);
    v=cell(levels,1);
    p=cell(levels,1);
    for i=1:levels
        a=filters{i};
        [~,coef]=infer_inter_fista(a,x,L,lambda,maxiter);
        [x,idx]=max_abs_pooling(coef,[2,2]);
        v{i}=x;
        p{i}=idx;
    end
end