classdef RobotSystem
    % Class which creates the robot defined by the user via the GUI


    properties
        model = [];                                  % Initialize robot Serial Link object
        workspaceDimentions = [303, 231]/1000;       % [width, height] in meters
        robotBasePosition = [];                      % [X, Y] in meters 

        startingVariables = [];                      % Starting position of the robot

        floorZactual = 0;                            % Adjusted floor Z coordinate


        % Hardware Variables
        device = [];
        servo1 = [];
        servo2 = [];
        servo3 = [];

        % Hardcoded motor calibration. Row corresponds to motor, and columns
        % represent slope and intercept respectively.
        % DH parameter as function of motor value (0-1)
        motorCalibration = [-135.78, 125.75; -142.43, 156.55; -27.5, 108.7];              

    end

    methods
        function obj = RobotSystem(robotBasePosition,startingVariables, floorZactual,...
                                   DHparametersAndType, jointsLimits, jointsOffsets)
            % Constructing an instance of the RobotSystem class using user
            % generated values

            obj.robotBasePosition = robotBasePosition;
            obj.startingVariables = startingVariables;
            obj.floorZactual = floorZactual;

            % Calling the "createRobotModel" function
            obj.model = obj.createRobotModel(DHparametersAndType, jointsLimits, jointsOffsets);


        end

        function model = createRobotModel(obj, DHparametersAndType, jointsLimits, jointsOffsets)

            % Create robot links using DHparametersAndType,
            % jointsLimits, and jointsOffsets matrices
            for l = 1:size(DHparametersAndType, 1)
                L(l) = Link(DHparametersAndType(l, :));
                L(l).qlim = jointsLimits(l, :);
                L(l).offset = jointsOffsets(l);
            end
            
            % Assigning the robot object
            model = SerialLink(L, 'name', 'robot');

            % Moving the base of the robot to the specified robot base
            model.base = transl(obj.robotBasePosition(1), obj.robotBasePosition(2), 0);

        end

        function plotModel(obj, title, GUIPosition)

            % Configure the figure to plot the robot
            close all                                                   % Close all figures
            fugure1Handle=figure(1);                                    % Get figure handle to configure
            figurePosition = GUIPosition;                               % Start off with the same position as GUI
            figurePosition(1) = figurePosition(1)+figurePosition(3);    % Move figure to the right side of the screen for convenience
            figurePosition(2) = figurePosition(2)-50;                   % Adjust figure y position
            set(fugure1Handle,'Position',figurePosition)                % Apply settings to the figure


            % Plot robot workspace with the clipboard dimensions and
            % scale the elements to look good. Use starting variables as
            % created by the user. Plot robot 2 times for different views
            for i = 1:2
                % Selecting subplot
                subplot(2,1,i)

                obj.model.plot(obj.startingVariables, 'workspace', ...
                    [0, obj.workspaceDimentions(1), ...
                    0, obj.workspaceDimentions(2), ...
                    0, .133 ], 'floorlevel',0, 'scale', .4);
                
                hold on 

                if(i == 1)
                    view ([0 0 90])
                end
            end

            % Name subplot
            sgtitle(title);
                
        end

        function ServoValues = robotVariablesToServoValues(obj, variables)
            % Function to set servos to certain positions based on the inputted variables 

            servo1Value = (variables(1)*180/pi-obj.motorCalibration(1,2))/obj.motorCalibration(1,1);
            servo2Value = (variables(2)*180/pi-obj.motorCalibration(2,2))/obj.motorCalibration(2,1);
            servo3Value = (variables(3)*1000-obj.motorCalibration(3,2))/obj.motorCalibration(3,1);

            ServoValues = [servo1Value, servo2Value, servo3Value];
        end

        function moveToPosition(obj, variables)
            % Remember previous variables by calling getpos
            lastVariables = obj.model.getpos();

            % Plotting the robot with the new variables
            obj.model.animate(variables);

            % Try to move physical robot
            if(~isempty(obj.device))
                servoValues = obj.robotVariablesToServoValues(variables);
                obj.servo1.writePosition(servoValues(1));
                obj.servo2.writePosition(servoValues(2));
                obj.servo3.writePosition(servoValues(3));
            end

            % EE positions
            lastRobotEEposition = [obj.model.fkine(lastVariables).t;1];
            robotEEposition = [obj.model.fkine(variables).t;1];
            


            % Try to draw in the workspace
            if((lastRobotEEposition(3) <= obj.floorZactual+.1/1000) && (robotEEposition(3) <= obj.floorZactual+.1/1000))
                figure(1)
                for i = 1:2
                    subplot(2, 1, i)
                    plot([lastRobotEEposition(1), robotEEposition(1)], [lastRobotEEposition(2), robotEEposition(2)], 'r', 'LineWidth',2);  
                end
            end
        end

        % The function that performs inverse kinematics to move the End-Effector to its next location based on user input
        function moveEE(obj, unitVector, moveStep)          

            % Getting the current position of the robot
            variables = obj.model.getpos();

            % Forming the end effector's transformation matrix by using forward kinematics with 
            % the joint angles of the current robot
            EETransformationMatrix = obj.model.fkine(variables);  

            % Altering the end effector's translation vector by however much the user 
            % wants to move the end effector position and in the preferred direction
            EETransformationMatrix.t = EETransformationMatrix.t+unitVector'*moveStep;  

            % Using Inverse kinematics to determine the new joint angles
            % utilizing the altered EE transformation matrix and taking the initial guess 
            % to be the current robot angles. The initial guess is crucial to avoid useless multiple solutions
            newRobotVariables = obj.model.ikine(EETransformationMatrix, 'mask', [1 1 1 0 0 0], 'q0', variables);  

            % An if statement that checks if the new joint angles found are within the limits of the physical motors.
            % If not, the new joint angles are ignored and not plotted.
            if(~isempty(newRobotVariables)) 
                                            
                % Check if all joints are within limits
                jointsAtLimitCheck = obj.model.islimit(newRobotVariables);
                jointsWithinLimits = all(jointsAtLimitCheck(:) == 0);
                
    
                if(jointsWithinLimits)
                    % Update robot plot
                    obj.moveToPosition(newRobotVariables);
                else
                    disp("Robot is outside the limits")
                end
            else
                disp("No solutions found")
            end
            
        end

        function setRobotToSelectedPose(obj, poseName)
            % As the function implies, this function simply sets the robot
            % to a predetermined pose. There is the "Starting pose" which
            % is preset to use "startingVariables" and the "Cap Pose" which
            % sets the motors to a configuration outside the clipboard for 
            % quick attachment and removal of the marker cap.
            newVariables = [];
            if(strcmp(poseName, 'Cap Pose'))
                newVariables = [obj.model.qlim(1, 2), obj.model.qlim(2, 1), obj.model.qlim(3, 1)];
            elseif(strcmp(poseName, 'Starting Pose'))
                newVariables = obj.startingVariables;
            end

            obj.moveToPosition(newVariables);

        end

        function obj = lowerOrRaiseToWrite(obj)
            % Function to raise or lower the marker against the clipboard            
            currentZ = obj.model.fkine(obj.model.getpos()).t(3);
            if(currentZ-.1/1000 <= obj.floorZactual) 
                % Marker is lowered, so raise pen by 8 mm 
                obj.moveEE([0,0,1], 8/1000);
            else
                changeToTouch = obj.floorZactual - currentZ;
                obj.moveEE([0,0,1], changeToTouch);
            end

        end

        function obj = setCurrentZasFloor(obj)
            % Simple function that sets the robot's current z position as
            % the floor AKA the clipboard
            obj.floorZactual = obj.model.fkine(obj.model.getpos()).t(3);
        end

        function variables = getModelVariables(obj)
            % Function to get robot's DH variables
            variables = obj.model.getpos();
        end

        function position = getModelEEPosition(obj)
            % Function to get the End Effector's position of the current robot
            position = obj.model.fkine(obj.model.getpos()).t;
        end

        function drawCircle(obj, centerXY, radius, steps) 
            % Function that draws a circle
            % This function allows the user to specify where the circle
            % should be drawn, the size of the circle, and how many steps
            % to draw the circle. The more steps, the higher the accuracy,
            % and the higher the wait is to draw it.

            % Prepare robot by moving EE to the circle center
            currentXY = obj.model.fkine(obj.model.getpos()).t(1:2);
            XYchange = centerXY - currentXY';
            
            obj.moveEE([XYchange, 0], 1);
            
            % Move to the right side of the circle
            obj.moveEE([1, 0, 0], radius);
            % Lower marker to write against the clipboard
            obj.lowerOrRaiseToWrite();
            
            % Initializing variable so for loop doesnt break.
            previousXYEEPosition = [centerXY(1)+radius, centerXY(2)];
            for a = linspace(0, 360, steps)
              % A for loop that, based on the number of steps, will take
              % numbers from 0 to 360 to be used in a formula that will
              % find a point in a circle and move the robot to that point. In the
              % end, this will collectively result in a circle-like shape being drawn. 
                newXYEEPosition = [centerXY(1) + cosd(a)*radius, centerXY(2) + sind(a)*radius];
                
                % Difference between new and old positions
                dXYEEPosition = newXYEEPosition-previousXYEEPosition;

                % Move robot to new point on the circle
                obj.moveEE([dXYEEPosition, 0], 1);

                % Reset previous EE position
                previousXYEEPosition = newXYEEPosition;

            end
        
            % Release marker from clipboard
            obj.lowerOrRaiseToWrite();
            % Move EE to original position
            obj.moveEE([-1, 0, 0], radius);
        end

        function drawLine(obj, startXY, endXY, steps)
            % A function to draw a line that takes the start and end of the
            % line as input as well as the number of steps it will take to
            % get there.

            % Prepare robot by moving EE to the starting location
            currentXY = obj.model.fkine(obj.model.getpos()).t(1:2);
            XYchange = startXY - currentXY';
            
            % Move robot to start of desired line
            obj.moveEE([XYchange, 0], 1);
            
            % Splitting up the line into chunks of X and Y points  
            lengthsOfLineXY = endXY-startXY;
            smallChangeInX = lengthsOfLineXY(1)/steps;
            smallChangeInY = lengthsOfLineXY(2)/steps;

            % Lower marker against the clipboard
            obj.lowerOrRaiseToWrite();

            for s = 1:steps
                % For loop that simply moves the EE to the small changes in
                % the X and Y directions in each step that will
                % collectively result in a line-like figure being drawn
                   obj.moveEE([smallChangeInX, smallChangeInY, 0], 1)
            end
            % Raise marker from clipboard
            obj.lowerOrRaiseToWrite();
        end

        function drawCross(obj, centerXY, radius, steps)
            % Function to draw an X. Essentially it is just drawing two
            % perpendicaular lines at a 45 degree angle, hence why the
            % "drawline" function is called twice with an alteration
            % in the rotation of the line.

            % Getting the XY coordinates of where to draw the X from user
            x = centerXY(1);
            y = centerXY(2);
            % Drawing the X
            obj.drawLine([x+radius*cosd(180+45), y+radius*sind(180+45)], [x+radius*cosd(45), y+radius*sind(45)], steps);
            obj.drawLine([x+radius*cosd(180-45), y+radius*sind(180-45)], [x+radius*cosd(-45), y+radius*sind(-45)], steps);

        end

        function drawGrid(obj, x, y, width, height)
            % Function to draw a grid wherever the user wants and at
            % whatever height and width. Essentially a grid is 4 lines
            % criss-crossed with each other, hence why the "drawline"
            % function is called 4 times.
            obj.drawLine([x+width/3, y], [x+width/3, y+height], height*1000/2)
            obj.drawLine([x+width/3*2, y], [x+width/3*2, y+height], height*1000/2)
            
            obj.drawLine([x, y+height/3], [x+width, y+height/3], width*1000/2);
            obj.drawLine([x, y+height/3*2], [x+width, y+height/3*2], width*1000/2); 
        end

        function moveTo(obj, targetXY)
            % Function that moves physical EE to desired location
            currentXY = obj.model.fkine(obj.model.getpos()).t(1:2);
            XYchange = targetXY - currentXY';
            obj.moveEE([XYchange, 0], 1);
        end

        function obj = connectArduino(obj)
            % Simple function to connect arduino to robot and initialize
            % servo motors
            com = char (inputdlg ('What COM Port?' , 'COM Select', 1, {'COM11'}));
            try
                obj.device = arduino (com, 'uno', 'libraries', 'Servo');
            catch
                msgbox ('Port failed', com, 'Arduino is already connected to the other model. Close the program and try again.');
                obj.device = [];
                return;
            end
            

            % Connect servos
            obj.servo1 = obj.device.servo ('D9','MinPulseDuration',900e-6,'MaxPulseDuration',2100e-6);
            obj.servo2 = obj.device.servo ('D10','MinPulseDuration',900e-6,'MaxPulseDuration',2100e-6);
            obj.servo3 = obj.device.servo ('D11', 'MinPulseDuration',1500e-6,'MaxPulseDuration',1900e-6);

            % Set to starting position
            obj.setRobotToSelectedPose('Starting Pose');
        end

    end
end