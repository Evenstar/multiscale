function ndf=ndf(x,a,func)
delta=1e-8;
[r,~,mx,mv]=size(a);
E=zeros(size(a));
    for i=1:mx
        for j=1:mv
            for k=1:r
                for l=1:r
                    y=a;
                    y(k,l,i,j)=y(k,l,i,j)+delta;
                    E(k,l,i,j)=(func(x,y)-func(x,a))/delta;
                end
            end
        end
    end
    ndf=E;
end