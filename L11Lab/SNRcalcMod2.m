%% How to normalize a signal for a given SNR
% We will normalize a signal such that the Likelihood ratio (LR) test for it has
% a given signal-to-noise ratio (SNR) in noise with a given Power Spectral 
% Density (PSD). [We often shorten this statement to say: "Normalize the
% signal to have a given SNR." ]

%%
% Path to folder containing signal and noise generation codes
% addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/DETEST'
% addpath 'https://drive.matlab.com/files/DATASCIENCE/statistical Methods/DATASCIENCE_COURSE/NOISE'
%Note for professor: I will add the path for the DATASCIENCE hope it make
%things easier when running the code
addpath ../DATASCIENCE_COURSE/DETEST
%FIXME missing path
addpath ../DATASCIENCE_COURSE/NOISE
addpath ../L6Lab
addpath ../L8Lab1

% This is the target SNR for the LR
snr = 10;

%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;


%%
% Generate the signal that is to be normalized 
freq0 = 30;  
phi0 = pi/2;

% Amplitude value does not matter as it will be changed in the normalization
A = 10; 
sigVec = gensinusig(timeVec,A,freq0,phi0);

%%
% Use iLIGOSensitivity.txt to generate a PSD
% (Exercise: Prove that if the noise PSD is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)
%Reading the LIGO sensitivity PSD 
iLIGOS= load('iLIGOSensitivity.txt', 'ascii'); 
%Low & high cutoff frequency 
low = iLIGOS(40,2); 
iLIGOS(1:42,2) = low;

high = iLIGOS(71,2);
iLIGOS(71:end,2) = high;

iLIGOS(2:end+1,:) = iLIGOS;
iLIGOS(1,1) = 0; %Hz
iLIGOS(1,2) = low;

iLIGOS = iLIGOS(1:85,:); % Cut window to 85
iLIGOS(85,1) = 3000; %Hz

% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
%psdPosFreq = noisePSD(posFreq);
%Interpolate the PSD iLIGOS data irregularly spaced frequencies to the
%required DT frequency
psdVals = interp1(iLIGOS(:,1),iLIGOS(:,2),posFreq);
psdVals = psdVals.^2; 

%figure;
figure;
loglog(posFreq,psdVals);
axis([0,posFreq(end),0,max(psdVals)]);
xlabel('Frequency (Hz)');
ylabel('PSD ((data unit)^2/Hz)');

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdVals);
% Normalize signal to specified SNR
sigVec = snr*sigVec/sqrt(normSigSqrd);

%% Test
%Obtain LLR values for multiple noise realizations
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdVals(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdVals);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdVals(:)],100,sampFreq);
    % Add normalized signal
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,sampFreq,psdVals);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);

%%
% A noise realization
figure;
plot(timeVec,noiseVec);
title('Time Domain-Signal')
xlabel('Time (sec)');
ylabel('Noise');
%%
% A data realization
figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sigVec);
title('Data realization for calculation of LR')
xlabel('Time (sec)');
ylabel('Data');