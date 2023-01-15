% Kinematics model for the Aesop 3000 using standard DH notation

% Open a file for output of test data... using the correct answer for the
% dh parameters

fid = fopen('test.dat', 'w');
% Distances are in centimeters
d0 = 0;
d1 = 0;
a2 = 39;
a3 = 9;
d5 = 29.5;
a6 = 1.65;
d7 = 10;    % Arbitrarily chosen

% create a parameter array

parameters = [d0, d1, a2, a3, d5, a6, d7];
revolute = 0;
prismatic = 1;

T_base = trans_std(0, d0, 0, 0);    % Extra transform to base of robot


% create a robot in robotic toolkit (put in dh parameters for every link)
L1 = link([0        0    0       0               prismatic               0], 'standard');
L1.qlim = [0, 38.1];
L2 = link([0        a2   0       0               revolute                0], 'standard');
L2.qlim = [-(315*pi/180)/2, (315*pi/180)/2];
L3 = link([pi/2     a3   0       0               revolute                0], 'standard');
L3.qlim = [-(282*pi/180)/2, (282*pi/180)/2];
L4 = link([pi/2     0    pi/2    0               revolute                pi/2], 'standard');
L4.qlim = [-(90*pi/180)/2, (90*pi/180)/2];
L5 = link([pi/2     0               pi      d5   revolute                pi], 'standard');
L5.qlim = [-(270*pi/180)/2, (270*pi/180)/2];
L6 = link([-pi/2    a6   pi/2    0               revolute                pi/2], 'standard');
L6.qlim = [-(180*pi/180)/2, (180*pi/180)/2];
L7 = link([pi       0               0       -d7   revolute               0], 'standard');
L7.qlim = [0, 38.1];

%build this robot
aesop = robot({L1 L2 L3 L4 L5 L6 L7}, 'Aesop 3000', 'Computer Motion', 'Standard DH Notation');

aesop.base = T_base;
count = 0;

%create a random set of numbers to generate 20 data points.

R = rand (20,7);
q = [0 0 0 0 0 0 0];

for i = 1:20
    %for each iteration, set the joint angles randomly
    l = L1.qlim; q(1) = l(1)+ diff(L1.qlim) * R(i,1);
    l = L2.qlim; q(2) = l(1)+ diff(L2.qlim) * R(i,2);
    l = L3.qlim; q(3) = l(1)+ diff(L3.qlim) * R(i,3);
    l = L4.qlim; q(4) = l(1)+ diff(L4.qlim) * R(i,4);
    l = L5.qlim; q(5) = l(1)+ diff(L5.qlim) * R(i,5);
    l = L6.qlim; q(6) = l(1)+ diff(L6.qlim) * R(i,6);
    l = L7.qlim; q(7) = l(1)+ diff(L7.qlim) * R(i,7);

    %do a forward kinematics calculation
    T = fkine (aesop, q);
    q
    pos = [T(1,4), T(2,4), T(3,4)]

    %plot (aesop, q, 'noerase', 'noshadow');
    %place these values in a file for later use.
    fprintf (fid, 'f% f% f% f% f% f% f% f% f% f%\n', q(1), q(2), q(3), q(4), q(5), q(6), q(7), pos(1), pos(2), pos(3));


end
fclose(fid);

parameters = [d0, d1, a2, a3, d5, a6, d7];

%try and find the original parameters based on optimization.
disp 'original parameters:'
parameters

%disturb the parameters
parameters(4) = 11;
parameters(3) = 34;
parameters(5) = 50;
parameters(6) = 3;

disp 'disturbed parameters:'
parameters

fminsearch ('exampleDHhobjective', parameters)