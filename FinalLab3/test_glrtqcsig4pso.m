%%Test script test_glrtqcsig4pso.m &  modifing from functionhandle.m &
%%glrtqcsig.m, glrtqcsig4pso and testcrcbgenqcsig scripts. 
%Path to folder containing signal and noise generation codes
addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/DETEST'
addpath 'https://drive.matlab.com/files/SDMBIGDAT19-master/CODES'
%Path for professor
% addpath ../DATASCIENCE_COURSE/DETEST 
% addpath ../SDMBIGDAT19/CODES 

% Number of samples and sampling frequency.
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq; 

%Signal Parameters and SNR quadratic chirp signal 
a1=10;
a2=3;
a3=3;
snr = 10; 
%Noise PSD we will used
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq); 

%Generating data realization with Colored Gaussian noise 
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
sigVec = crcbgenqcsig(timeVec,snr,[a1,a2,a3]);

% Signal normalized to SNR=10
[sigVec,~]=normsig4psd(sigVec,sampFreq,psdPosFreq,10);
dataVec = noiseVec+sigVec;

%Array of volumes A, for parameter a1, with minimum and maximum
%values a1min & a1max, & ranges a2min & a2max.. but not arrays 
a1_min = 1;
a1_max = 10;
a2_min = 1;
a2_max = 5;
a3_min = -20;
a3_max = 20;
A = linspace(a1_min,a1_max,sampFreq);
rmin = [a1_min a2_min a3_min];
rmax = [a1_max a2_max a3_max];

%Matrix X rows i contain [x1, x2, x3]: Constructed standardized coordinate
%values
X = zeros(length(A), 3);
   
X(:, 1) = (A - a1_min)/(a1_max - a1_min);
X(:, 2) = (a2 - a2_min)/(a2_max - a2_min);
X(:, 3) = (a3 - a3_min)/(a3_max - a3_min);

%Using data realization, compute the fitness values for X using
%glrtqcsig4pso.m 
params = struct('snr', snr,...
                  'sampFreq', sampFreq,...
                  'psdPosFreq', psdPosFreq,...'
                  'dataX', timeVec,...
                  'dataY', dataVec,...
                  'dataXSq',timeVec.^2,...
                  'dataXCb',dataVec.^3,...
                  'rmin',rmin,...
                  'rmax',rmax ...
                  );
%Fitness values 
fitV = glrtqcsig4pso(X,params); 

%Plotting the fitness values against the values in A 
figure;
plot(A, fitV);
title('Fitness Values vs Signal Parameters');
xlabel('Signal Parameters');
ylabel('Fitness Values');


