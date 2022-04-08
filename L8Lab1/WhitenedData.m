%Task: Read testData.txt, Whiten Signal and Plot Spectrogram 

%Read testData.txt 

data = load('testData.txt'); 

%Columns 1 timeVec & Column 2 to signalVec in terms of data vectors
timeVec = data(:,1); 
sigVec = data(:,2); 


%Calculating nSamples & sample frequency of data 
nSamples = length(timeVec); 
samplFreq = (nSamples-1)/max(timeVec);
%First 5 seconds of data
freqVec = 0:1/samplFreq:5;

%Power Spectral Density Function estimate via PWelch 
[pxx,f]=pwelch(sigVec(1:length(freqVec)), 514,[],[],samplFreq);

%Designing Whitening Filter fir2 filter for target T(f)=sqrt(PSD) where PSD is the estimated PSD of first 5 seconds
filtOrder = 500; 
b = fir2(filtOrder,f/(samplFreq/2),1./sqrt(pxx));
%Whitening the data Normalized to two sided PSD
whitenedData =  sqrt(samplFreq)*fftfilt(b,sigVec);

%Plotting time series of testData & Whitening data 
figure; 
subplot(2,1,1); 
plot(timeVec, sigVec);
title("Test Data")
xlabel("Time (s)")
ylabel("Amplitude"); 

subplot(2,1,2); 
plot(timeVec, whitenedData); 
title("Whitened Data");
xlabel("Time (s)"); 
ylabel("Amplitude"); 


%Plot a spectrogram of Test Data
%----------------
%Declare length of windows & overlap
winLen = 0.09;%sec
ovrlp = 0.07;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
%FIXME you have mistakenly used 3 subplots
% subplot(3,1,1);
subplot(2,1,1);
imagesc(T,F,abs(S)); axis xy;
title('Spectrogram of Test Data')
xlabel('Time (sec)');
ylabel('Frequency (Hz)');


%Plot a spectrogram of Whitening Data
%----------------
winLen = 0.09;%sec
ovrlp = 0.07;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[Sout,Fout,Tout]=spectrogram(whitenedData,winLenSmpls,ovrlpSmpls,[],samplFreq);
%FIXME you have mistakenly used 3 subplots
% subplot(3,1,2);
subplot(2,1,2);
imagesc(Tout,Fout,abs(Sout)); axis xy;
title('Spectrogram of Whitening Data')
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

%Plotting the spectrogram before and after the whitening data I see a
%signal clearer in the data after whitening using WINDOW 0.09, & NOVERLAP
%0.07. 






