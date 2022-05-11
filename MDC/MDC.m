%%Final Exam-Detection & Estimation 

%Addpath
% addpath https://drive.matlab.com/files/statistical Methods/DATASCIENCE_COURSE/DETEST 
% addpath https://drive.matlab.com/files/statistical Methods/DATASCIENCE_COURSE/MDC
% addpath https://drive.matlab.com/files/SDMBIGDAT19-master/CODES 
% addpath https:/drive.matlab.com/files  
%Path for professor 
% addpath ../DATASIENCE_COURSE/DETEST
% addpath ../DATASCIENCE_COURSE/MDC 
% addpath ../SDMBIGDAT19-master/CODES 
addpath ../FinalLab4;
addpath ../FinalLab3;
addpath ../L11Lab;

%Load training data containing only noise:
data1 = load('TrainingData.mat'); 
noiseVec = data1.trainData;
sampFreq = data1. sampFreq; %Hz 

%Loading Analysis Data to be analyzed: 
dataVec = load('AnalysisData.mat').dataVec;   
nSamples = length(dataVec); 
dataLen = nSamples/sampFreq;
timeVec = (0:(nSamples-1))/sampFreq;

% Number of independent PSO runs
nRuns = 8;
%Parameter search ranges & snr: 
rmin = [40 1 1];
rmax = [100 50 15]; 
SNR = 10; 

%%Estimate the noise PSD (modify scripts from Lab11)
[pxx,posFreq] = pwelch(noiseVec, 1024,[],[],sampFreq);
psdVec = interp1(1:length(pxx),pxx,linspace(1,length(pxx),1025),'cubic');
posFreq = interp1(1:length(posFreq),posFreq,linspace(1,length(posFreq),1025),'linear');
psdPosFreq = psdVec;


%%Set parameter using glrtqcpso.m function from FinalLab3&4 
inParams = struct('rmin',rmin,...
                     'rmax',rmax, ...
                     'dataX',timeVec, ...
                     'dataXSq',timeVec.^2, ...
                     'dataXCb',timeVec.^3, ...
                     'dataY',dataVec,...
                     'psdVec', psdVec,...
                     'psdPosFreq',psdPosFreq, ...
                     'sampFreq',sampFreq ...
                  ); 


% GLRTQCHRPPSO runs PSO on the glrtqcsig4pso fitness function. 
outStruct = glrtqcpso(inParams,struct('maxSteps',2000),nRuns); 

%% Estimated quadratic chirp coefficients & use fitness value from the best
% rRun. PSO negative of fitness values for minimization 
%FIXME Error: Sending in strings a1, a2, a3 rather than numerical values
% a1= num2str(outStruct.bestQcCoefs(1));
% a2= num2str(outStruct.bestQcCoefs(2));
% a3= num2str(outStruct.bestQcCoefs(3)); 
a1= outStruct.bestQcCoefs(1);
a2= outStruct.bestQcCoefs(2);
a3= outStruct.bestQcCoefs(3); 
glrt = outStruct.bestFitness; 
glrt = -glrt;  
%Maximum Likelihood Ratio test 
llr = sqrt(glrt);
%%Obtain GLRT values for noise realizations (modify functions from lab 11). 
nH0Data = 1000; %Generate data 
n = 0; 
for i = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    %FIXME Error: Sending in strings a1, a2, a3 rather than numerical values
    %FIXME Bigger error: Should have called glrtqcpso here with inParams.dataY = noiseVec
    %nglrts = glrtqcsig(noiseVec,psdPosFreq,a1,a2,a3);
    nglrts = glrtqcsig(noiseVec,psdPosFreq,a1,a2,a3);
    if llr <= nglrts
        n = n+1;
    end
end
% Significance Calculations. 
signif = n/nH0Data;
%%My Analysis respond: Throughout this observation I estimated significance 0 
%detection at my first successful RUN (I was debugging alot). However, 
%I was able to get a estimated significane of 0.008. 
%There is a qc signal (detection) in the data from such low significance. 


% Plots
figure;
hold on;
plot(timeVec,dataVec,'.');
plot(timeVec,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
legend('Data', 'Estimated signal'); 
title('Data & Estimated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3)),...
                             '; Estimated significance: ',num2str(signif)]);

