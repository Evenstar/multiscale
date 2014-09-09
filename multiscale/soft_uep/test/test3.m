x=double(imread('../data/barbara.png'));
x=x/255;
x=imresize(x,0.5);

%%
a=randn(5,5,1,2);
for k=1:20
    k
    na=a;
    a=sparsity_step(x,a,1);
    norm(na(:)-a(:),1)
    df=normalize_4d_dict(inter_df2(x,a));
    a=a-1/k*df;
    norm(na(:)-a(:),1)
    figure(1);
    for i=1:2
        subplot(1,2,i);
        imagesc(a(:,:,1,i));
        axis equal;
        colorbar
    end
end