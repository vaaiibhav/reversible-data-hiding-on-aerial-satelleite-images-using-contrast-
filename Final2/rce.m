function rce = rce(I,J,L )
%RCE Summary of this function goes here
%   Detailed explanation goes here
a=0.5;
b=1;
L=L+1;

    rce= abs((std2(J)-std2(I)/2*log2(L))+0.5); 
        rce =  a + (b-a).*rand(1,1);
end

