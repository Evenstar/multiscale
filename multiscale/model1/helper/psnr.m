function out=psnr(x,y)
mse=sum((x(:)-y(:)).^2)/numel(x);
maxi=x(:).^2;
out=10/log(10)*log(max(maxi)/mse);
end
