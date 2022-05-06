tic
%% Test harness for rosenbrocktestfun modifing test_crbpso_par.m script
addpath https://drive.matlab.com/files/SDMBIGDAT19-master/CODES
%addpath ../SDMBIGDAT19/CODES
% The fitness function called is rosenbrocktestfunc. 
ffparams = struct('rmin',-30,...
                     'rmax',30 ...
                  );
% Fitness function handle.
fitFuncHandle = @(x) rosenbrocktestfunc(x,ffparams);

% Dimensionality of the search space
nDim = 2;

% Call PSO and use best-of-M-runs
nRuns = 4; %Number of PSO runs
psoOut = struct('totalFuncEvals',[],...
                    'bestLocation',zeros(1,nDim),...
                    'bestFitness',[]);
%We need to have one psoOut struct for each run: make a struct array with
%each element initialized to be the same as the first
for lpruns = 2:nRuns
    psoOut(lpruns) = psoOut(1);
end
parfor lpruns = 1:nRuns
        %Reset random number generator for each worker such that the
        %pseudo-random sequence is different for them but they repeat
        %everytime this code is run
        rng(lpruns);
        %PSO run 
        psoOut(lpruns) = crcbpso(fitFuncHandle,nDim);
end
%Find best run
bestRun = 1;
for lpruns = 2:nRuns
    if psoOut(lpruns).bestFitness < psoOut(bestRun).bestFitness
        bestRun = lpruns;
    end
end
% Estimated parameters
% Best standardized and real coordinates found.
stdCoord = psoOut(bestRun).bestLocation;
[~,realCoord] = fitFuncHandle(stdCoord);
disp(['Best run:',num2str(bestRun)]);
disp(['Best location:',num2str(realCoord)]);
disp(['Best fitness:', num2str(psoOut(bestRun).bestFitness)]);
disp('Info for all runs:');
for lpruns = 1:nRuns
    stdCoord = psoOut(lpruns).bestLocation;
    [~,realCoord] = fitFuncHandle(stdCoord);
    disp(['Best location for run ',num2str(lpruns),': ',num2str(realCoord)]);
    disp(['Best fitness for run ',num2str(lpruns),': ', num2str(psoOut(lpruns).bestFitness)]);
    disp('*****************');
end
toc

%FIXME: Added plotting of the fitness function
figure;
%Range of each coordinate 
xRng = ffparams.rmax - ffparams.rmin;
%Generate grid in XY plane
[x1,x2] = meshgrid(ffparams.rmin:0.05:ffparams.rmax,ffparams.rmin:0.05:ffparams.rmax);
%Standardize the coordinates before feeding to the fitness function
sx1 = (x1-ffparams.rmin)/xRng;
sx2 = (x2-ffparams.rmin)/xRng;
%Evaluate fitness values on the grid: each grid point's coordinates occupy
%one row
fVal = fitFuncHandle([sx1(:),sx2(:)]);
%Reshape to turn into a matrix (like the 2D grid)
fVal = reshape(fVal,[length(x2(:,1)),length(x1(1,:))]);
%Make surface plot
surf(x1,x2,fVal,'FaceAlpha',0.5)
xlabel('first coordinate');
ylabel('second coordinate');
zlabel('Fitness value');
shading interp;
%SDM
shading interp;