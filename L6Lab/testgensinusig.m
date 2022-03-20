
%% Plot the Sinusoidal Signal function
addpath ../L5Lab/
%NOTE This path is redundant because you copied gensinusig here. 
%NOTE The idea is to avoid code duplication and keep only one copy of gensinusig.
% Signal parameters
freq0 = 20; %change frequency for the plot of spectogram that matches my expectations   
phi0 = pi/2;
A = 10;
% Instantaneous frequency 
maxFreq = freq0; %Maxmimum is equal to the constant frequency of the sinusoid

%5 times the Nyquist sampling frequency
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

%Plot a spectrogram
%----------------
winLen = 0.6;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
title('Spectrogram of Sinusoidal Signal')
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
%Figure for Spectrogram: With the window length of 0.6 and 0.1 overlap, I
%change the freq0 to 20Hz in order to meet my expectation for a nice linear
%graph. We can see our x axis time and y-axis frequency stay constant  
% at 20z through time. Using Specgrm QCdemo and changing some parameters and 
%nSample frequency it gives me the same constant linear plot for frequency
%and time. 
 
