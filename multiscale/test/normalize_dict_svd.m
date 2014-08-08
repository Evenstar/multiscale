function newdict=normalize_dict_svd(dict)
[U,~,V]=svd(dict);
newdict=U*eye(size(U,1),size(V,1))*V;
end