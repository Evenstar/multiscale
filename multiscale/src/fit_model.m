function newfilter=fit_model(img,opt)
%initialize filters
newfilter=cell(opt.layers,1);

%start computation
for k=1:opt.layers
    %initialize input for current unit
    x=[];
    if k==1
        x=img;
    else
        [x,~]=max_abs_pooling(v,[2,2]);
    end
    %initialize filter for current unit
    a=opt.filter{k};
    
    for i=1:opt.max_iter(k);
        %compute coefficient
        [~,v]=infer_inter_fista(a,x,opt.L(k),opt.lambda(k),opt.fista_iter(k),opt.shape{k});
        %update dictionary for current unit
        a=inter_dict_frcg(x,v,a,opt.cg_iter(k));
        %normalize dicitonary element to have unit l2 length
        a=normalize_4d_dict(a);
        %compute objective function value
        E=log10(objective_3d(x,a,v,opt.lambda(k)));
        fprintf('Training layer %d/%d, iteration %d/%d, log objective %8.6f\n',...
            k,opt.layers,i,opt.max_iter(k),E);
    end
    %update filter
    newfilter{k}=a;
end
end