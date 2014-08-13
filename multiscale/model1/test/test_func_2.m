function [newa]=test_func_2(x,a,v,maxiter)
m=size(a,1);
r=sqrt(size(a,2));
b=zeros([r,r,m]);
for i=1:m
    b(:,:,i)=conv2(rot90(v(:,:,i),2),x,'valid');
end
b=b(:);
a=cgs(@ax,b,1e-7,maxiter);
    function out=ax(a)
        dict=reshape(a,[r,r,m]);
        recx=zeros(size(x));
        for i=1:m
            recx=recx+conv2(v(:,:,i),dict(:,:,i),'valid');
        end
        out=zeros(size(dict));
        for i=1:m
            out(:,:,i)=conv2(rot90(v(:,:,i),2),recx,'valid');
        end
        out=out(:);
    end
newa=reshape(a,[r*r,m]);
newa=newa';

end