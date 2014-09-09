function [recx,v,p,s]=infer_multiple_layers(img,opt,l)
for i=1:l
    [recx,v,p,s]=infer_cur_fista(img,opt,i);
    opt.s{i}=s;
    opt.p{i}=p;
end