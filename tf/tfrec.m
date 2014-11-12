function rec_signal=tfrec(struct)
%tfdec performs a 1-level frame transform reconstruction using a speficied filter.
%Boundary condition can be either one of the following: 'ppd', 'sym','symh', it
%should be consistent with the decomposition transform.
dict=struct.dict;
f=struct.df;
signalSize=struct.signalSize;
coef=struct.coef;

[m,r]=size(dict);
rec_signal=[];
for i=1:m
    temp=upsample(coef{i},f);
    rec_signal=[rec_signal;conv(temp,conj(fliplr(dict(i,:))),'valid')];

end
rec_signal=sum(rec_signal);
rec_signal=rec_signal(1:signalSize)/f;

end