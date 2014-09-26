function dict=get_initial_guess(x,r,m,N)
CImages=x;
trainImg=titan_build_train(CImages,r,N);

opts.patchSize=[r,r];
opts.numAtoms=m;
opts.lambda=10;
opts.maxIter=200;
[dict,recImg,ratio]=nenya_train(trainImg,opts);
psnr(trainImg,recImg)
ratio
resImg=trainImg-recImg;
L1=sum(abs(resImg(:)))
end