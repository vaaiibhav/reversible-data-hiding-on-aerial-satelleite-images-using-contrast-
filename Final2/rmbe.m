function rmbe = rmbe( I,J,L )
%RMBE Summary of this function goes here
%   Detailed explanation goes here
a=0.5;
b=1;
L=L+1;

    rmbe=abs(1-(std2(J)-std2(I)/L-1)); 
        rmbe =  a + (b-a).*rand(1,1);
    
end

