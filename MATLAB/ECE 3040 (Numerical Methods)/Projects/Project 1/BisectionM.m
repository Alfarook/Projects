function [z] = BisectionM(f, x_lower, x_upper, NumOfIterations)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% if ~exist('RelativeErrorLim','var')
%     % An if statement that makes the RelativeError argument an optional input
%     RelativeErrorLim = irrelevant;
% end


try
    f(x_lower)*f(x_upper) < 0;
catch
    disp('Bisection Method cannot work with two same sign guesses');
    return
end

x_m = 0; %Initializing x_m so I can get x_mOld

for i = 1:1:NumOfIterations

x_mOld = x_m;
x_m = (x_lower + x_upper) / 2;

if (f(x_m)*f(x_lower) < 0)
    x_upper = x_m;
else
end


if (f(x_m)*f(x_lower) > 0)
    x_lower = x_m;
else
end



if (f(x_m)*f(x_lower) == 0)
    return
end


% RelativeErrorLim = RelativeErrorLim/100; % Converting to a percent
PercentError = abs((x_m - x_mOld)/x_m)*100;

% if (PercentError > RelativeErrorLim)
%  % do nothing and continue for loop
% else
%     z = ("The root is " + x_m + " and the Percent Error is " + PercentError );
% break   
% 
% end  

z = ["The root is " + x_m + " and the Percent Error is " + PercentError, "x_lower = " +x_lower+ ". x_upper = " +x_upper ];

end

