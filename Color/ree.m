function ree = ree( I,J )
%REE Summary of this function goes here
%   Detailed explanation goes here
L=8;
    ree = (entropyfilt(J) - entropyfilt(I)/2*log2(L))+0.5;
    

end

