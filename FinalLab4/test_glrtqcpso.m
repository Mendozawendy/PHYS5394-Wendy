%Test script for glrtacpso for data realization 
%Path to folder containing signal and noise generation codes
addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/DETEST'
addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/SIGNALS'
addpath 'https://drive.matlab.com/files/SDMBIGDAT19-master/CODES'
%Path for professor
% addpath ../DATASCIENCE_COURSE/DETEST 
% addpath .../DATASCIENCE_COURSE/SIGNALS
% addpath ../SDMBIGDAT19/CODES 
% addpath ../FinalLab3

%% Data realization
% Number of samples and sampling frequency.
nSamples = 512; %Hz
sampFreq = 512;
timeVec = (0:(nSamples-1))/sampFreq; 

%Signal Parameters and SNR quadratic chirp signal 
a1=8;
a2=3;
a3=3;
snr = 10; 

%%PSO search range 
% Number of independent PSO runs
nRuns = 8;
%Search ranges 
rmin = [1 1 1];
rmax = [180 10 10];

%Noise PSD we will used
noisePSD = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq); 

%Generating data realization with Colored Gaussian noise 
fltOrdr = 100;
outNoise = statgaussnoisegen(nSamples+fltOrdr-1,[posFreq(:), psdPosFreq(:)],fltOrdr,sampFreq);
outNoise = outNoise(fltOrdr:end);

sigVec = crcbgenqcsig(timeVec,snr,[a1,a2,a3]);

% Signal normalized to SNR=10
[sigVec,~]=normsig4psd(sigVec,sampFreq,psdPosFreq,snr);
dataVec = outNoise+sigVec;  

%Input parameter for glrtqcpso.m
inParams = struct('rmin',rmin,...
                     'rmax',rmax, ...
                     'dataX',timeVec, ...
                     'dataXSq',timeVec.^2, ...
                     'dataXCb',timeVec.^3, ...
                     'dataY',dataVec,...
                     'psdPosFreq',psdPosFreq, ...
                     'sampFreq',sampFreq ...
                  );
% GLRTQCHRPPSO runs PSO on the glrtqcsig4pso fitness function. 
outStruct = glrtqcpso(inParams,struct('maxSteps',1000),nRuns);


% Plots
figure;
hold on;
plot(timeVec,dataVec,'.');
plot(timeVec,sigVec);
for lpruns = 1:nRuns
    plot(timeVec,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',4.0);
end
plot(timeVec,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
legend('Data','Signal',...
       ['Estimated signal: ',num2str(nRuns),' runs'],...
       'Estimated signal: Best run');
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);





