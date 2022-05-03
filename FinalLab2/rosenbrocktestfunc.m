function [fitVal, varargout] = rosenbrocktestfunc(xVec, params)
%All function are made by Dr. Mohanty crcbpsotestfun sample. 
%A Generalized Rosenbrock test function for for rosenbrocktestfunc
%Compute the Rosenbrock fitness function for each row of X.  The fitness
%values are returned in F. X is standardized, that is 0<=X(i,j)<=1. P has
%two arrays P.rmin and P.rmax that are used to convert X(i,j) internally to
%actual coordinate values before computing fitness: X(:,j) ->
%X(:,j)*(rmax(j)-rmin(j))+rmin(j). 
%
%For standardized coordinates, F = infty if a point X(i,:) falls
%outside the hypercube defined by 0<=X(i,j)<=1.
%
%[F,R] =  rosenbrocktestfunc(X,P)
%returns the real coordinates in R. 
%
%[F,R,Xp] = rosenbrocktestfunc(X,P)
%Returns the standardized coordinates in Xp. This option is to be used when
%there are special boundary conditions (such as wrapping of angular
%coordinates) that are better handled by the fitness function itself.
%Based on crcrpsotestfunc.m By Dr. Soumya Mohanty 
%Wendy Mendoza, May 3, 2022 
%Function: f3 = sum{100(x-x^2)^2+(x-1)^2} 


%rows: points
%columns: coordinates of a point
[nrows,~]=size(xVec);

%storage for fitness values
fitVal = zeros(nrows,1);
validPts = ones(nrows,1);

%Check for out of bound coordinates and flag them
validPts = crcbchkstdsrchrng(xVec);
%Set fitness for invalid points to infty
fitVal(~validPts)=inf;
%Convert valid points to actual locations
xVec(validPts,:) = s2rv(xVec(validPts,:),params);


for lpc = 1:nrows
    if validPts(lpc)
    % Only the body of this block should be replaced for different fitness
    % functions
        x = xVec(lpc,:);  
        fitVal(lpc) = sum(100*(x(2)-x(1)^2)^2+(x(1)-1)^2); 
        
    end
end

%Return real coordinates if requested
if nargout > 1
    varargout{1}=xVec;
    if nargout > 2
        varargout{2} = r2sv(xVec,params);
    end
end

