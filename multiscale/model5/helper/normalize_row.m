function newdict=normalize_row(dict)
m=size(dict,1);
for i=1:m
    dict(i,:)=dict(i,:)/norm(dict(i,:),2);
end
newdict=dict;
end