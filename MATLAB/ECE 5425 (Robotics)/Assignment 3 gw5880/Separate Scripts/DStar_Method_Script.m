% Script that goes around a grid using D* Method of Path
% Planning

%  Starting timer to find out how long the algorithm takes
tic

% Making Tic-Tac-Toe grid obstacle
map = zeros(230,300);

map(88:152,48:52)=1;
map(88:152,68:72)=1;
map(108:112,28:92)=1;
map(128:132,28:92)=1;

%Variable to sum up all the individual paths
TotalPath = [];

% Centers of each cell on the outside of the grid starting from the top
% center and going clockwise
goalPoints = [60  80  80  80  60  40  40  40  60;
              140 140 120 100 100 100 120 140 140;];

% Starting location near the first goal point
startLocation = [45;165];

% Initializing the Dstar Constructor with the obstacle map
DStarMethod = Dstar(map);

% Plotting map
DStarMethod.plot();

for i = 1:numcols(goalPoints)
    % Using D* Method to compute a cost map using a goal
    % and the obstacle map
    DStarMethod.plan(goalPoints(:,i));

    % Displays the animation of robotic movement from start to the goal
    path = DStarMethod.query(startLocation);

    % Saving each individual path. Paths are saved as Nx2 matrices of XY
    % coordinates
    TotalPath = vertcat(TotalPath, path);
    startLocation = goalPoints(:,i);

    % Plotting Heat Map
    DStarMethod.plot(path)
end

% Ending timer to find total time elapsed
toc

% Plotting all the individual paths together
DStarMethod.plot(TotalPath)
