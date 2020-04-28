clc
close all
clear all
 warning off
%% Change direction
prev_dir = pwd; file_dir = fileparts(mfilename('fullpath')); cd(file_dir);
addpath(genpath(pwd));
%% Main code
% I = double(imread('lenna.pgm'));
[filen, pathn] =uigetfile('*.*','Select Image');
imagefile = strcat(pathn,filen);
I = imread(imagefile);
answer = inputdlg('Enter The String to Watermark','Reversible Watermarking',1);
embedRate = 0.5;
[wI,actualEmbedRate,PSNR,embedded_string] = reversible(I,embedRate,answer);
figure,imshow(I),title('orignal image ');
figure(2)
hist(I(:),0:255) 
figure,imshow(wI/255),title('Hiding Image'); 
J = histeq(I);
figure,imshow(J),title('Enhanced Image'); 
ree = ree(I,J);
rce= rce(I,J);
rmbe = rmbe(I,J);
%rss = rss(I,J);
fprintf ('THe Ree ');
disp(ree);
fprintf ('THe Rce ');
disp(rce);
fprintf ('THe Rmbe' );
disp(rmbe);
%fprintf ('THe Rss '+rss);
fprintf('The PSNR of Image is: %.2f dB \n',PSNR);
fprintf('The actual embedding rate is %.2f bpp \n',actualEmbedRate);
h = msgbox(embedded_string);
