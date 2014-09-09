function st=proj_forward(x,opt)
%initialize variables
layers=opt.layers;
v=cell(layers,1);
p=cell(layers,1);
s=cell(layers,1);
%start computation layerwise
for i=1:layers
    %filter for current unit
    a=opt.filter{i};
    %compute coefficient
    [~,coef]=infer_inter_fista(a,x,opt.L(i),opt.lambda(i),opt.fista_iter(i),opt.shape{i});
    %store size
    s{i}=size(coef);
    %perform max pooling based on absolute value
    [x,idx]=max_abs_pooling(coef,opt.shape{i});
    %store coefficients and their positions
    v{i}=x;
    p{i}=idx;
end
st.v=v;
st.p=p;
st.s=s;
end