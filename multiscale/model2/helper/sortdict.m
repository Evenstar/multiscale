function Dict=sortdict(dict)
Dict=dict;
[~,I]=sort(abs(sum(Dict,2)),'descend');
s=sum(Dict(I(1),:),2);
if s<0
    Dict=Dict*(-1);
end

temp=Dict(1,:);
Dict(1,:)=Dict(I(1),:);
Dict(I(1),:)=temp;
Dict=Dict/sqrt(trace(Dict*Dict'));
end

