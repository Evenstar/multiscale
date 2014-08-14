function [recx,newopt]=learn_multiple_layers(img,opt,l)
for i=1:l
    for k=1:opt.outer_iter(i)
        [recx,v,p,s]=infer_cur_fista(img,opt,i);
        psnr(img,recx)
        opt.s{i}=s;
        opt.p{i}=p;
        newdict=infer_dict_cur_frcg(img,v,opt,i);
        opt.filter{i}=newdict;
    end
end
newopt=opt;
end