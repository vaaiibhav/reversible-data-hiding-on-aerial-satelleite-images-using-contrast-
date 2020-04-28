function rce = rce(I,J )
%RCE Summary of this function goes here
%   Detailed explanation goes here
L=8;

    rce= (std2(J)-std2(I)/2*log2(L))+0.5; 
end

