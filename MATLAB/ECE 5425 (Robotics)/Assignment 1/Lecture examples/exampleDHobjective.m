function error = exampleDHobjective(parameters)

% error is zero.
error = 0;
% make a new robot with the given dh parameters
revolute = 0;
prismatic = 1;
T_base = trans_std(0, parameters(1), 0, 0);
L1 = link([0        0               0       0               prismatic               0], 'standard');
L2 = link([0        parameters(3)   0       0               revolute                0], 'standard');
L3 = link([pi/2     parameters(4)   0       0               revolute                0], 'standard');
L4 = link([pi/2     0               pi/2    0               revolute                pi/2], 'standard');
L5 = link([pi/2     0               pi      parameters(5)   revolute                pi], 'standard');
L6 = link([-pi/2    parameters(6)   pi/2    0               revolute                pi/2], 'standard');
L7 = link([pi       0               0       -parameters(7)   revolute               0], 'standard');
aesop = robot({L1 L2 L3 L4 L5 L6 L7}, 'Aesop 3000', 'Computer Motion', 'Standard DH Notation');
aesop.base = T_base;

% open the file of precompute values.
fid = fopen ( 'test.dat', 'r');

test = [0 0 0 0 0 0 0 0 0 0]; % the pair of joint angles and pos values.

for i = 20, % 20 is the number of measured points
    %read in the comparison values from the file
    s = fgets (fid);
    test = sscanf(s, '%f %f %f %f %f %f %f %f %f %f');

    % compute a new forward kinematics based on new parameters
    q = test (1:7);
    pos = test (8:10);
    T = fkine (aesop, q);
    newpos = T (1:3, 4);
    % compute error
    each_error = sqrt (sum ((pos - newpos).^2));
    error = error + each_error;
end

fclose (fid)

% compute average error.
error = error/20;
