function [newdict,E]=tree_solver(img,dict,opt)
lambda=opt.lambda;
L=opt.L;
maxiter=opt.maxiter;
fista_max_iter=opt.fista_max_iter;
cg_max_iter=opt.cg_max_iter;
E=zeros(maxiter,1);
for i=1:maxiter
    [~,coef]=infer_tree_fista(dict,img,L,lambda,fista_max_iter);
    dict=tree_dict_frcg(img,coef,dict,cg_max_iter);
    dict=normalize_row(dict);
    E(i)=log10(objective(img,coef,dict,lambda));
    fprintf('Iteration %d/%d, log objective value %8.4f\n', i,maxiter, E(i));
end
newdict=dict;
end