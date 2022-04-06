%Simulating LIGO noise using colGauss..& statgauss..functions to produce noise
%realization & estimate the PSD

%Reading the LIGO sensitivity PSD 
iLIGOS= load('iLIGOSensitivity.txt', 'ascii'); 

%Sampling frequency for noise realization
%Change my Hz multiple times notice my function for filtering PSD 
sampFreq = 6000; %Hz
%Number of samples to generate
nSamples = 10*sampFreq;
timeVec = (0:(nSamples-1))/sampFreq; %Time samples

%Pre-Filtereing S(f<=50)=S(f=50) & S(f>=700)=S(f=700)
lowcutoff = 50; %Hz
highcutoff = 700; %Hz 

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


% Design FIR filter with T(f)= square root of target PSD
fltrOrdr = 500;
freqVec = iLIGOS(:,1);
sqrtPSD = sqrt(iLIGOS(:,2));
b = fir2(fltrOrdr,freqVec/(sampFreq/2),sqrtPSD);
%Generate a WGN realization and pass it through the designed filter
inNoise = randn(1,nSamples); %generates nsample realization of zero mean
outNoise = sqrt(sampFreq)*fftfilt(b,inNoise); 


%Estimate the PSD using pwelch 
[pxx,f]=pwelch(outNoise, 256,[],[],sampFreq);
figure;
loglog(f,pxx);
title('Estimated PSD (pwelch) of LIGO Noise Realization');
xlabel('Frequency (kHz)');
ylabel('PSD'); 

