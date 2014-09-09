function newdict=normalize_4d_dict(dict)
[~,~,mx,mv]=size(dict);
newdict=zeros(size(dict));
for i=1:mx
    for j=1:mv
        r=norm(dict(:,:,i,j),'fro');
        newdict(:,:,i,j)=dict(:,:,i,j)/r;
    end
end
end