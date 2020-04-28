function rmbe = rmbe( I,J )
%RMBE Summary of this function goes here
%   Detailed explanation goes here
L=8;    
    rmbe=1- (std2(J)-std2(I)/L-1); 

    
end

