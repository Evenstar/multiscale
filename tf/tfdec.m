function struct=tfdec(signal, dict, boundary_condition,downsample_factor)
%tfdec performs a 1-level frame transform analysis using a speficied filter.
%Boundary condition can be either one of the following: 'ppd', 'sym','symh'.
if nargin==3
    f=1;
else
    f=downsample_factor;
end
[m,r]=size(dict);
coef=cell(m,1);
signal_ext=wextend('1D',boundary_condition,signal,r-1);
for i=1:m
    temp=conv(signal_ext,dict(i,:),'valid');
    coef{i}=downsample(temp,f);
end
struct.coef=coef;
struct.df=f;
struct.dict=dict;
struct.signalSize=length(signal);
end