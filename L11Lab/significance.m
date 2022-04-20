%Generate M data realizations under (. (signal absent) and use the associated
% GLRT values to estimate the significance of each of the 3 GLRT values for the 3 
% given data realizations

%%
% Path to folder containing signal and noise generation codes
addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/DETEST'
%Note for professor: I will add the path for the DATASCIENCE hope it make
%things easier when running the code
% addpath ../DATASCIENCE_COURSE/DETEST

% Read 3 Data.txt realization
data1 = load('data1.txt','-ascii').';
data2 = load('data2.txt','-ascii').';
data3 = load('data3.txt','-ascii').';

% Parameters for data realization
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;

%Signal Parameters 
a1=10;
a2=3;
a3=3;

%Noise PSD we will used from SNRCalc.m
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq); 

%Calculating glrt for 3 data realization
glrt1 = glrtqcsig(data1,psdPosFreq,a1,a2,a3);
glrt2 = glrtqcsig(data2,psdPosFreq,a1,a2,a3);
glrt3 = glrtqcsig(data3,psdPosFreq,a1,a2,a3);

%Obtain GLRT values for multiple noise realizations
nH0Data = 90000; %generate M data
for n = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    gltrs = glrtqcsig(noiseVec,psdPosFreq,a1,a2,a3);
end 

% calculate significance
signf_1 = sum(gltrs>=glrt1)/nH0Data; 
signf_2 = sum(gltrs>=glrt2)/nH0Data; 
signf_3 = sum(gltrs>=glrt3)/nH0Data;  

disp(signf_1);
disp(signf_2);
disp(signf_2);



 
