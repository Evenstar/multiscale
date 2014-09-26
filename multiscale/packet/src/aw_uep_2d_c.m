function loss=aw_uep_2d_c(A)
shape=size(A);
if length(shape)==2
    m=size(A,1);
    n=sqrt(size(A,2));
    loss=aw_uep_2d_c_src(reshape(A,[m,n,n]));
elseif length(shape)==3
    loss=aw_uep_2d_c_src(A);
end
end
