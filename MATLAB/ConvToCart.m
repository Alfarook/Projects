function [z] = ConvToCart(r, theta)

x = r*cosd(theta);
y = r*sind(theta);
z = ["x-value: "+ x , "y-value: "+ y];
% By outputting an array instead of the individual variables, the output of
% the function is much more user friendly because it outputs what the user
% expects. Without the array, the output would only show the first variable
% 'x' and not the variable 'y' unless the user specifies.
end

