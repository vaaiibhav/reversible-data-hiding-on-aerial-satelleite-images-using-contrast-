% This function is to embed the LSB-planes of A into B
function [W,payload,boundaryMap,multiInd] = embedB(B,m,T2)

length_m = length(m);
multiInd = false;
% calculate the histogram of estimating errors.
pixelFlag = 0; % parameter for calculating white pixels or black pixels (0 for white)
[diffHist, LN, LM, RN, RM] = histGen(B,pixelFlag);                      

diffStart = 256;                  
para = zeros(4,1);
payload = 0;
if diffHist(LM + diffStart) + diffHist(RM+ diffStart) > length_m - payload
    if diffHist(LM + diffStart) + diffHist(RM+ diffStart) < T2*sum(diffHist)
        LM = LN; RM = RN;
        while diffHist(LM + diffStart) + diffHist(RM + diffStart) <  length_m && LM < RM % recalculate LM, RM
            LM=LM+1;
            RM=RM-1;
        end
        if LM == RM
            LM = RM-1;
        end
        para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN;
        [wB,payload,boundaryMap] = embedWhite(B,m,para);
        W = wB;
        payload = payload - length(boundaryMap);
      
    else
        para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN;
        [wB,payload,boundaryMap] = embedWhite(B,m,para);
        W = wB;
        payload = payload - length(boundaryMap);
        
    end
else
    para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN;  
    [wB1,payload1,boundaryMap1] = embedWhite(B,m,para);
    payload = payload1 - length(boundaryMap1);
    boundaryMap = boundaryMap1;
  
    pixelFlag = 1; % parameter decided to calculate black pixels
    [diffHist, LN, LM, RN, RM] = histGen(wB1,pixelFlag);
    if diffHist(LM + diffStart) + diffHist(RM+ diffStart) > length_m - payload 
        if diffHist(LM + diffStart) + diffHist(RM+ diffStart) < T2*sum(diffHist)
            LM = LN; RM = RN;
            while diffHist(LM + diffStart) + diffHist(RM + diffStart) <  length_m - payload && LM < RM %recalculate LM, RM
            LM=LM+1;
            RM=RM-1;
            end
            if LM == RM
                LM = RM-1;
            end
            para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN; 
            m = m(payload+1:end);
            [wB2,payload2,boundaryMap2] = embedBlack(wB1,m,para);
            payload = payload + payload2 - length(boundaryMap2);
            boundaryMap = [boundaryMap;boundaryMap2];
            W =wB2;
          
        else
            para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN; 
            m = m(payload+1:end);
            [wB2,payload2,boundaryMap2] = embedBlack(wB1,m,para);
            payload = payload + payload2 - length(boundaryMap2);
            boundaryMap = [boundaryMap;boundaryMap2];
            W =wB2;
         
        end
    else 
        multiInd = true; % adopt multilayer embedding scheme.
        para(1) = LN; para(2) = LM; para(3) = RM; para(4) = RN;
        m = m(payload+1:end);
        [wB2,payload2,boundaryMap2] = embedBlack(wB1,m,para);
        payload = payload + payload2 - length(boundaryMap2);
        boundaryMap = [boundaryMap;boundaryMap2];
        W = wB2;
   
    end
end
        
        
        
    
    

    
    
    




    






