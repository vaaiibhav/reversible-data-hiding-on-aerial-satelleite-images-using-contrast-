function [wI,actualEmbedRate,PSNR,embedded_data, L] = reversible(I,embedRate,answer,T1,T2)

if (nargin < 3 || nargin > 5)
   wI = -Inf;
   actualEmbedRate = -Inf;
   PSNR = -Inf;
   return;
end

if (nargin == 3)
    T1 = 0.25;
    T2 = 0.2;
    eRe = 0.5;

end

if (nargin == 4)
    T2 = 0.2;
end
%----------- image partition -----------------
embedded_string=answer;
embedRate=eRe;
I = double(I);
[h,w]= size(I);
dataLength = embedRate * h * w;
if embedRate <= T1
    T1Ind = false;
    AHeight = ceil(dataLength/w);
    [A, B, AInd] = imgPartition(I, AHeight); % find proper partition of I.
else
    T1Ind = true;
    AHeight = ceil(dataLength/(w * 2));
    [A, B, AInd] = imgPartition(I, AHeight); 
end
%----------- embed Bit Stream of Location Map --------------
data = round(rand(dataLength,1));
wA = embedA(A,data,T1Ind);
%---------- Message Bits Embedding -embedding process -------------

if ~T1Ind
    m = mod(A,2);
    m = m(:);
    m = m(1:dataLength);
else
    m1 = mod(A,2);
    m1 = m1(:);
    m2 = mod(floor(A/2),2);
    m2 = m2(:);
    m = [m1;m2];
    m = m(1:dataLength);
end
embeddingRound = 1;

[wB,payload,boundaryMap,multiInd]= embedB(B,m,T2);
while multiInd % multilayer embedding is needed.
    embeddingRound = embeddingRound + 1;
  
    d = m(payload + 1:end);
    [wB,payload_m,boundaryMap_m,multiInd]= embedB(wB,d,T2);
    payload = payload + payload_m;
    boundaryMap = [boundaryMap;boundaryMap_m];    
end

%---------- catenate W_A and W_B -------------
wI = catenate(wA,wB,AInd,AHeight);

%---------- calculation PSNR and actual embedding rate -------------
PSNR = psnr(I,wI);
actualEmbedRate = payload /(h*w) ;
L =embeddingRound;
embedded_data= embedded_string;
    
    

    





