%This function is to calculate PSNR between two images.
function PSNR = psnr(I,W)
[m,n] = size(I);
[h,w] = size(W);
if m ~= h && n ~= w
    error('Two images must have the same size.')
end
delta = 1/(m*n) * sum( ( I(:) - W(:) ).^2 );
PSNR = 10 * log10( 255^2/delta );
PSNR = PSNR -10;