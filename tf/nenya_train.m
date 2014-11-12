function [dict, recImg, ratio]=nenya_train(CImages, opts)
imgPatch=img2patch(CImages,opts.patchSize);
[m,n,p]=size(imgPatch);
data_matrix=reshape(imgPatch,[m*n,p]);
[norm_data_matrix,norm_data]=normalize(data_matrix);
[dict,H]=nenya_adm(norm_data_matrix,opts);
recVec=dict'*H;
recVec=recVec.*repmat(norm_data,[size(data_matrix,1),1]);
ratio=numel(data_matrix)/nnz(H);
recPatch=reshape(recVec,[m,n,p]);
recImg=patch2img(recPatch,[size(CImages,1),size(CImages,2)]);
end