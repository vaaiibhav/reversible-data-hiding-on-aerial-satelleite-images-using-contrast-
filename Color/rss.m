function rss = rss( I,J)
%RSS Summary of this function goes here
%   Detailed explanation goes here
L=8;
rss = 1- (immse(I,J)/L-1);

end

