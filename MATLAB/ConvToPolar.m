function [array] = ConvToPolar(x,y)

r = sqrt(x^2+y^2);
theta = atand(y/x);
array = ["r-value: " + r, "theta-value: " + theta];
% Pretty much exact copy of the 'ConvToCart" function
end

