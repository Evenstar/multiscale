function []=view_4d_filter(dict)
[~,~,mx,mv]=size(dict);
for i=1:mx
    for j=1:mv
        subplot(mx,mv,(i-1)*mv+j);
        imshow(dict(:,:,i,j),[]);
        axis equal
    end
end