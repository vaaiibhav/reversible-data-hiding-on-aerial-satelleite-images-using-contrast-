function rss = rss( I,J,L)
%RSS Summary of this function goes here
%   Detailed explanation goes here
a=0.5;
b=1;
L=L+1;
rss = abs(1- (immse(I,J)/L-1));
   rmbe =  a + (b-a).*rand(1,1);
end

