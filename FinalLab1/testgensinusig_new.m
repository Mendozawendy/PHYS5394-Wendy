%%Create a test script to run gensinusig_new 
% Signal parameters
P = struct('freq0', 20,...
            'phi0', pi/2.0);
A = 10; %Amplitude
% Instantaneous frequency 
maxFreq = P.freq0; %Maxmimum is equal to the constant frequency of the sinusoid

%5 times the Nyquist sampling frequency
samplFreq = 5*(2*maxFreq);
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:.1;

% Number of samples
nSamples = length(timeVec);
% Generate the signal
sigVec = gensinusig_new(timeVec,A,P);

%Plot the first signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('Time Series of Sinusoidal Signal '); 
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