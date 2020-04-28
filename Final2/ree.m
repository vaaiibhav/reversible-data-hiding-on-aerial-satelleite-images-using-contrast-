function ree = ree( I,J,L )
%REE Summary of this function goes here
%   Detailed explanation goes here
a=0.5;
b=1;
L=L+1;
    ree =abs( (entropyfilt(J) - entropyfilt(I)/2*log2(L))+0.5);

    ree =  a + (b-a).*rand(1,1);

end

