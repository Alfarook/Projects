classdef TicTacToe
    % The game class which allows the user to play TicTacToe against the
    % robot
    properties
        % Addressable variables within each object created from the class TicTacToe
        robotSystem = [];

        gridPosition = [];
        gridSize = [];

        GUIposition = [];

        playerShape = 0;
        robotShape = 0;

        % States: 0-circle, 1-cross, -1-nothing
        gameBoard = [];

        selectedCellMatrix = [0,0,0;0,1,0;0,0,0];

    end

    methods

        function obj = TicTacToe(GridPositionMM, GridSizeMM, robotBasePosition,startingVariables, floorZactual,...
                DHparametersAndType, jointsLimits, jointsOffsets, GUIposition)

            % Constructing an instance of the TicTacToe class using user
            % generated values
            obj.gridPosition = GridPositionMM/1000;
            obj.gridSize = GridSizeMM/1000;
            obj.GUIposition = GUIposition;

            % Creating the robot that will be used to play TicTacToe
            obj.robotSystem = RobotSystem(robotBasePosition, startingVariables, floorZactual,...
                DHparametersAndType, jointsLimits, jointsOffsets);

            % Plotting the robot twice. "Gambler" is just a title.
            obj.robotSystem.plotModel("Gambler", GUIposition);
            
            % Asking user if arduino should be connected which would enable
            % the servo motors
            answer = questdlg("Connect Arduino?");
            if(strcmp(answer, 'Yes'))
                obj.robotSystem = obj.robotSystem.connectArduino();
            end

            % Move EE to the center of the game board
            obj.robotSystem.moveTo(obj.gridPosition + obj.gridSize/2);

            % Start with board filled with -1, signifying empty positions
            obj.gameBoard = ones(3,3)*-1;

            % Asking user to decide which symbol will represent each player
            playerShapeName = questdlg('Play with...', ...
                'Player Shape', ...
                'Cross', 'Circle', 'Cross');

            % Setting the symbol for each player based on user
            % configuration
            obj.playerShape = 1;
            switch playerShapeName
                case 'Cross'
                    obj.playerShape = 1; % 1 for cross and 0 for circle
                    obj.robotShape = 0;
                otherwise
                    obj.playerShape = 0; % 1 for cross and 0 for circle
                    obj.robotShape = 1;
            end

            % Setting the play space by drawing the grid per user
            % designated values
            obj.robotSystem.drawGrid(obj.gridPosition(1), obj.gridPosition(2), obj.gridSize, obj.gridSize);
            % Moving to the center of the grid
            obj.moveToCell(obj.selectedCellMatrix);
        end

        function obj = resetTheGame(obj)
            % Reset plot
            obj.robotSystem.plotModel("Gambler", obj.GUIposition);

            % Move EE to the center of the game board
            obj.robotSystem.moveTo(obj.gridPosition + obj.gridSize/2);

            % Reset game board
            obj.gameBoard = ones(3,3)*-1;
            obj.selectedCellMatrix = [0,0,0;0,1,0;0,0,0];

            % Reset player shape
            playerShapeName = questdlg('Play with...', ...
                'Player Shape', ...
                'Cross', 'Circle', 'Cross');
            
            % Setting the symbol for each player based on user
            % configuration 
            obj.playerShape = 1;
            switch playerShapeName
                case 'Cross'
                    obj.playerShape = 1; %1 for cross and 0 for circle
                    obj.robotShape = 0;
                otherwise
                    obj.playerShape = 0; %1 for cross and 0 for circle
                    obj.robotShape = 1;
            end

            % Setting the play space by drawing the grid per user
            % designated values
            obj.robotSystem.drawGrid(obj.gridPosition(1), obj.gridPosition(2), obj.gridSize, obj.gridSize);
            % Moving to the center of the grid
            obj.moveToCell(obj.selectedCellMatrix);
        end

        function robotIsFirst = determineIfRobotIsFirst(obj)
            % Simple function that determines which player goes first
            robotIsFirst = randi(2) == 2;
        end

        function position = moveMatrixToCellPosition(obj, moveMatrix)
            % Function to tell the robot where to move next in the
            % TicTacToe grid
            [r, c] = find(moveMatrix, 1);

            cellPositionWithRespectToCenterCell = [r, c]-[2, 2];
            centerCellPosition = obj.gridPosition+[obj.gridSize, obj.gridSize]/2;
            position = centerCellPosition + [cellPositionWithRespectToCenterCell(2), -cellPositionWithRespectToCenterCell(1)]*obj.gridSize/3;
        end

        function obj = moveToCell(obj, moveMatrix) 
            % Function that moves EE to the board position described by passed matrix
            obj.selectedCellMatrix = moveMatrix;

            targetCellPosition = obj.moveMatrixToCellPosition(moveMatrix);
            obj.robotSystem.moveTo(targetCellPosition);

        end

        function drawO(obj) 
            position = obj.robotSystem.getModelEEPosition();
            % Function that calls the "drawCircle" function from the
            % "RobotSystem" class using the current position of the EE
            obj.robotSystem.drawCircle([position(1),position(2)], obj.gridSize/10, 50)
        end

        function drawX(obj)
            % Function that calls the "drawCross" function from the
            % "RobotSystem" class using the current position of the EE
            position = obj.robotSystem.getModelEEPosition();
            obj.robotSystem.drawCross([position(1),position(2)], obj.gridSize/7, 4)
        end

        function obj = computeMinimaxRobotMove(obj)
            bestScore = -9999999999; % Start the best score with very low number
            bestMoveMatrix = [];

            if (all(obj.gameBoard == -1))
                % If robot goes first, robot chooses optimal starting
                % position
                bestMoveMatrix = [1 0 0; 0 0 0; 0 0 0];
            else
                % Loop though possible board moves
                for r = 1:3
                    for c = 1:3
                        % If cell is empty, create a virtual game board
                        % where robot goes in that cell
                        if(obj.gameBoard(r, c) == -1)
                            newGameBoard = obj.gameBoard;
                            newGameBoard(r,c) = obj.robotShape;

                            newBoardMoveMatrix = zeros(3,3);
                            newBoardMoveMatrix(r, c) = 1;

                            % Compute score for new game board using minimax
                            % recursion
                            score = obj.minimax(newGameBoard, true, 0);

                            if(score > bestScore)
                                bestScore = score;
                                bestMoveMatrix = newBoardMoveMatrix;
                            end
                        end
                    end
                end
            end

            obj.selectedCellMatrix = bestMoveMatrix;
            % Move robot to selected cell
            obj.moveToCell(obj.selectedCellMatrix);

        end

        function score = minimax(obj, boardIteration, toMinimize, depth)
            % Check winners at board iteration
            obj.gameBoard = boardIteration;
            outcome = obj.checkForWin();

            if(outcome == 1) % Robot wins
                score = 10;
                return;
            elseif(outcome == 2) % Human wins
                score = -10;
                return;
            elseif(outcome == 3) % tie
                score = 0;
                return;
            end

            if(toMinimize)
                score = 9999999999; % Start the best score with very high number because we try to minimize
                for r = 1:3
                    for c = 1:3
                        % Loop though possible board moves
                        if(boardIteration(r, c) == -1)
                            % If cell is empty, create a virtual game board
                            % where robot goes in that cell
                            newGameBoardIteration = boardIteration;
                            newGameBoardIteration(r,c) = obj.playerShape;

                            % Compute score for new game board using minimax
                            % recursion
                            newDepth = depth +1;
                            iterationScore = obj.minimax(newGameBoardIteration, false, newDepth);

                            if(iterationScore < score)
                                score = iterationScore;
                            end
                        end
                    end
                end

                return;

            else
                score = -9999999999; %start the best score with vary low number because we try to maximize
                for r = 1:3
                    for c = 1:3
                        % Loop though possible board moves
                        if(boardIteration(r, c) == -1)
                            % If cell is empty, create a virtual game board
                            % where robot goes in that cell
                            newGameBoardIteration = boardIteration;
                            newGameBoardIteration(r,c) = obj.robotShape;

                            % Compute score for new game board using minimax
                            % recursion
                            newDepth = depth +1;
                            iterationScore = obj.minimax(newGameBoardIteration, true, newDepth);

                            if(iterationScore > score)
                                score = iterationScore;
                            end
                        end
                    end
                end

                return;
            end
        end

        function [obj, message, isValid] = playerTurn(obj)
            % Function that allows the player to play their turn.

            % Find which cell in the TicTacToe grid was selected
            [targetCellR, targetCellC] = find(obj.selectedCellMatrix, 1);
            % Check if cell is empty
            if(obj.gameBoard(targetCellR, targetCellC) == -1)
                % Drawing the player's symbol in the selected cell
                obj.gameBoard(targetCellR, targetCellC) = obj.playerShape;
                if(obj.playerShape == 0)
                    obj.drawO();
                else
                    obj.drawX();
                end

                % Return message for GUI element and flag for valid move
                message = 'You made a turn.';
                isValid = true;
            else
                % Return message for GUI element and flag for invalid move
                message = 'Cell is already played. Select another cell and try again.';
                isValid = false;
            end
        end

        function obj = robotTurn(obj)
            % Function that describes where the robot will go
            [targetCellR, targetCellC] = find(obj.selectedCellMatrix, 1);

            % Update game board
            obj.gameBoard(targetCellR, targetCellC) = obj.robotShape;

            if(obj.robotShape == 0)
                obj.drawO();
            else
                obj.drawX();
            end

        end

        function outcome = checkForWin(obj)          
            % Possible outcomes: 0 - game currently running, 1 - robot wins, 2 - user wins, 3 - tie      
            outcome = 0;

            % While loop to isolate winning identifiers
            while(true)
                playerWon = false;
                robotWon = false;
                % Check game board rows
                for r = 1:3
                    playerWon = all(obj.gameBoard(r, :) == obj.playerShape);
                    robotWon = all(obj.gameBoard(r, :) == obj.robotShape);

                    % Determine outcome
                    if(robotWon)
                        outcome = 1;
                        break;
                    elseif(playerWon)
                        outcome = 2;
                        break;
                    end
                end


                % Check game board columns
                for c = 1:3
                    playerWon = all(obj.gameBoard(:, c) == obj.playerShape);
                    robotWon = all(obj.gameBoard(:, c) == obj.robotShape);

                    % Determine outcome
                    if(robotWon)
                        outcome = 1;
                        break;
                    elseif(playerWon)
                        outcome = 2;
                        break;
                    end
                end


                % Check game board diagonals
                diagonal1 = [];
                diagonal2 = [];
                for i = 1:3
                    diagonal1(end+1) = obj.gameBoard(i, i);
                    diagonal2(end+1) = obj.gameBoard(4-i, i);
                end
                playerWon = all(diagonal1 == obj.playerShape);
                robotWon = all(diagonal1 == obj.robotShape);

                % Determine outcome
                if(robotWon)
                    outcome = 1;
                    break;
                elseif(playerWon)
                    outcome = 2;
                    break;
                end

                % Check game board diagonals
                playerWon = all(diagonal2 == obj.playerShape);
                robotWon = all(diagonal2 == obj.robotShape);

                % Determine outcome
                if(robotWon)
                    outcome = 1;
                    break;
                elseif(playerWon)
                    outcome = 2;
                    break;
                end

                break;
            end

            % If no winners detected, check for tie
            if(outcome == 0)
                % Try finding empty cell
                index = find(obj.gameBoard == -1, 1);
                if(isempty(index))
                    outcome = 3;
                end
            end
        end

    end
end

