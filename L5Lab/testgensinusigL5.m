
%% Plot the Sinusoidal Signal function
addpath ../L4lab

% Signal parameters
freq0 = 2;  
phi0 = pi/2;
A = 10;
% Instantaneous frequency 
maxFreq = freq0; %Maxmimum is equal to the constant frequency of the sinusoid

%5 times the Nyquist sampling frequency
samplFreq = 30; %Hz
samplFreq = 5*(2*maxFreq);
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Number of samples
nSamples = length(timeVec);
% Generate the signal
sigVec = gensinusig(timeVec,A,freq0,phi0);

%Plot the first signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('Sinusoidal Signal 5 times Nyquist Sampling Frequency'); 
xlabel('Time (sec)'); 
ylabel('Amplitude'); 

%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1; 
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
 % FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);


%Plot periodogram
figure;
plot(posFreq,abs(fftSig),'Marker','.','MarkerSize',24);
title('Periodogram of Sinusoidal Signal'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude');






 
