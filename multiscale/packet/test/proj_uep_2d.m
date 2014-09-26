function newdict=proj_uep_2d(dict,maxiter)
[r,~,mv]=size(dict);
x=randn(64);
    function out=obj(dict)
        dict=reshape(dict,[r,r,mv]);
        v=zeros(size(x,1)+r-1,size(x,2)+r-1,mv);
        for i=1:mv
            v(:,:,i)=conv2(rot90(dict(:,:,i),2),x);
        end
        v(1:2:end,:,:)=0;
        v(:,1:2:end,:)=0;
        recx=zeros(size(x));
        for i=1:mv
            recx=recx+conv2(v(:,:,i),dict(:,:,i),'valid');
        end
        rx=recx-x;
        out=norm(rx(:),2);
    end
obj(dict)
options=optimset('maxiter',maxiter,'MaxFunEval',2000000);
newdict=fminunc(@obj,dict(:),options);
newdict=reshape(newdict,[r,r,mv]);
obj(newdict)
end