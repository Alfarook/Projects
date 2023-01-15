function [T] = tmat(xr,yr, zr, xt, yt, zt)
% This function takes in 3 rotation parameters and the translation  
% vector, and outputs a 4x4 transformation matrix follwing the ZYZ
% convention

xr = xr * pi/180;   %converting inputted degrees into radians for MATLAB to process correctly
yr = yr * pi/180;
zr = zr * pi/180;
T = [cos(xr) -sin(xr) 0; sin(xr) cos(xr) 0; 0 0 1];         % Making the x rotation matrix if there's any x rotation. Here I am following the ZYZ Convention
T = T * [cos(yr) 0 sin(yr); 0 1 0; -sin(yr) 0 cos(yr)];     % Multiplying the x rotation matrix with the y matrix to compute any inputted rotations
T = T * [cos(zr) -sin(zr) 0; sin(zr) cos(zr) 0; 0 0 1];     % Again, Multiplying the x and y rotation matrix with the z matrix to compute any inputted rotations
T = [T [xt yt zt]'; 0 0 0 1];                               % Forming the transformation matrix
end