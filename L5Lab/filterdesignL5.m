%% Generate sum of 3 sinusoids 

sampFreq = 1024; %Hz
nSamples = 2048; 
timeVec = (0:(nSamples-1))/sampFreq;


% Signal parameters 
A1 = 10; 
freq1 = 100; 
phi1 = 0; 

A2 = 5;
freq2 = 200;
phi2 = pi/6;

A3 = 2.5;
freq3 = 300;
phi3 = pi/4;

 % Declare the 3 sinusoids
s1 = gensinusig(timeVec,A1,freq1,phi1);
s2 = gensinusig(timeVec,A2,freq2,phi2);
s3 = gensinusig(timeVec,A3,freq3,phi3);

% Add 3 sinusoids & maxfreq
sigVec = s1 + s2 + s3;
maxFreq = freq1 + freq2 + freq3; 
disp(['The maximum frequency of the sum of sinusoids is ', num2str(maxFreq)]);


% Filter design
% Design filter 1 allow s1 to pass through filter
filtOrder = 30; % Use same order for all
b = fir1(filtOrder, (150)/(sampFreq/2), 'low'); % Pass frequencies below 150 Hz
% Apply the filter
filtS1 = fftfilt(b, sigVec);

% Design filter 2 to pass s2 through filter high and low passband
b2 = fir1(filtOrder, [150/(sampFreq/2) 250/(sampFreq/2)], 'high'); % Pass frequencies above 150-250 Hz
b3 = fir1(filtOrder, 250/(sampFreq/2), 'low'); % Pass frequencies below 250 Hz
% Apply bandpass filter to low and high cutoff
filtS2 = fftfilt(b2, sigVec); % low cutoff
filtS2 = fftfilt(b3, filtS2); % high cutoff

% Design filter 3 to let s3 pass highpass
b4 = fir1(filtOrder, 250/(sampFreq/2), 'high'); % Pass frequencies above 250 Hz
% Apply highpass
filtS3 = fftfilt(b4, sigVec); 

% Periodograms
% Length of data
dataLen = timeVec(end)-timeVec(1);
% DFT sample corresponding to Nyquist frequency
kNyq = floor(length(timeVec)/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);

% FFT of unfiltered signal sigVec
fftSig = fft(sigVec);
fftSig = fftSig(1:kNyq);

% FFT of filtered signal 1
fftSig1 = fft(filtS1);
fftSig1 = fftSig1(1:kNyq);

% FFT of filtered signal 2
fftSig2 = fft(filtS2);
fftSig2 = fftSig2(1:kNyq);

% FFT of filtered signal 3
fftSig3 = fft(filtS3); 

fftSig3 = fftSig3(1:kNyq);

% Plot the periodograms 
% 4 row, 1 column figure of 4 plots
figure;
subplot(4,1,1); % Plot the periodogram of the input signal once
plot(posFreq, abs(fftSig));
title('Input: Signal Periodogram');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

subplot(4,1,2); % Plot output periodogram of each filtered signal 
plot(posFreq, abs(fftSig1));
title('Output: Lowpassed Periodogram');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

subplot(4,1,3); % Plot output periodogram of each filtered signal 
plot(posFreq, abs(fftSig2));
title('Output: Bandpassed Periodogram');
ylabel('Magnitude');
xlabel('Frequency (Hz)');

subplot(4,1,4); % Plot output periodogram of each filtered signal 
plot(posFreq, abs(fftSig3));
title('Output: Highpassed Periodogram'); 
ylabel('Magnitude');
xlabel('Frequency (Hz)');

% Plot the signals
% 3 row, 1 column figure of 3 plots
figure;
subplot(3,1,1); 
plot(timeVec, sigVec);
plot(timeVec, filtS1);
title('Lowpass cutoff 150 Hz (s1)');
ylabel('Magnitude');
xlabel('Time');

subplot(3,1,2);
plot(timeVec, sigVec);
plot(timeVec,filtS2);
title('Bandpass cutoff 150-250 Hz (s2)');
ylabel('Magnitude');
xlabel('Time');

subplot(3,1,3);
plot(timeVec, sigVec);
plot(timeVec, filtS3);
title('Highpass cutoff 250 Hz (s3)'); 
ylabel('Magnitude');
xlabel('Time');