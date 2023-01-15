% Script that goes around a grid using PRM Method of Path
% Planning

%  Starting timer to find out how long the algorithm takes
tic

% Making Tic-Tac-Toe grid obstacle

% Reduced map size to get a less eratic path
map = zeros(165,105);

map(88:152,48:52)=1;
map(88:152,68:72)=1;
map(108:112,28:92)=1;
map(128:132,28:92)=1;

% Additional obstacles to get a more condensed path
map(1:75   ,1:105)=1;
map(1:165   ,1:15)=1;

% Variable to sum up all the individual paths
TotalPath = [];

% Centers of each cell on the outside of the grid starting from the top
% center and going clockwise
goalPoints = [60  80  80  80  60  40  40  40  60;
              140 140 120 100 100 100 120 140 140;];

% Starting location near the first goal point
startLocation = [45;165];

% Initializing the PRM Contructor with the obstacle map
PRMMethod = PRM(map);

for i = 1:numcols(goalPoints)
    % Using PRM Method to compute a roadmap with random points
    PRMMethod.plan();

    % Displays the animation of robotic movement from start to the goal
    path = PRMMethod.query(startLocation, goalPoints(:,i));

    % Saving each individual path. Paths are saved as Nx2 matrices of XY
    % coordinates
    TotalPath = vertcat(TotalPath, path);
    startLocation = goalPoints(:,i);
end

% Ending timer to find total time elapsed
toc

% Plotting all the individual paths together
PRMMethod.plot(TotalPath)

