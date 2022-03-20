%%TEST the customrand and customrandn function 

%%Parameters to generate the function uniform distribution 
M = 1000; %trials
a = -2; 
b = 1;  

%Generate the pseudorandom numbers with uniform distribution 
ru = customrand(M,a,b); 
%Generate the theoretical uniform pdf range for density 
x_u = linspace(a-1,b+1,M); %limits for plots
y_u = pdf('unif',x_u,a,b); 

%%Parameters to generate the function normal distribution 
M = 10000; %trials
sigma = 1.5; 
mu = 2; 

%Generate the pseudoradomn number with normal distribution
r = customrandn(M,a,b); 
%Generate the theoretical normal distribution pdf range for density 
x_n = linspace(sigma-6,mu+6,M); 
y_n = pdf('norm',x_n,sigma,mu); 

%Plotting for PDF & Histogram for Uniform Distribution 
%FIXME From Lab7 Tasks: "On top of each histogram, plot the respective PDFs" 
% figure 
% subplot(2,1,1)
% plot(x_u,y_u); 
% title('PDF for uniform distribution between -2, and 1')
% xlabel('Trials')
% ylabel('Values')
% 
% subplot(2,1,2)
% histogram(ru, 'normalization','pdf')
% title('Histrogram for uniform distribution trials values')
% xlabel('Values')
% ylabel('Probability')

%NOTE See the changes below and implement the same for the normal pdf
figure
%subplot(2,1,2)
histogram(ru, 'normalization','pdf')
%title('Histrogram for uniform distribution trials values')
% xlabel('Values')
% ylabel('Probability')
%subplot(2,1,1)
hold on;
plot(x_u,y_u); 
%title('PDF for uniform distribution between -2, and 1')
xlabel('x')
ylabel('p_Y(x)')
legend('histogram', 'pdf');
title(['Uniform pdf U(x;',num2str(a),',',num2str(b),')'])



%Plotting for PDF & Histrogram for Normal Distribution 
figure 
subplot(2,1,1)
plot(x_n,y_n); 
title('PDF for normal distribution between -2, and 1')
xlabel('Trials')
ylabel('Values')

subplot(2,1,2)
histogram(r, 'normalization','pdf')
title('Histrogram for normal distribution trial values')
xlabel('Values')
ylabel('Probability')




