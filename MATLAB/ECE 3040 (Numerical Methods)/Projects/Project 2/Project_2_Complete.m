classdef Project_2_Complete < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        ECE3040Project2UIFigure         matlab.ui.Figure
        LoadMenu                        matlab.ui.container.Menu
        SwingDataMenu                   matlab.ui.container.Menu
        SwingData16inMenu               matlab.ui.container.Menu
        SwingData212inMenu              matlab.ui.container.Menu
        SwingData318inMenu              matlab.ui.container.Menu
        SwingData424inMenu              matlab.ui.container.Menu
        CoefficientsMenu                matlab.ui.container.Menu
        stOrderMenu                     matlab.ui.container.Menu
        ndOrderMenu                     matlab.ui.container.Menu
        rdOrderMenu                     matlab.ui.container.Menu
        IdealPeriodsecondsEditField     matlab.ui.control.NumericEditField
        IdealPeriodsecondsEditFieldLabel  matlab.ui.control.Label
        GravConstPercentErrorEditField  matlab.ui.control.NumericEditField
        GravConstPercentErrorEditFieldLabel  matlab.ui.control.Label
        RecordSwing4Button              matlab.ui.control.StateButton
        LPforGravConstantDropDown       matlab.ui.control.DropDown
        LPforGravConstantDropDownLabel  matlab.ui.control.Label
        RecordCoeffecients3rdorderButton  matlab.ui.control.Button
        RecordCoeffecients2ndorderButton  matlab.ui.control.Button
        RecordCoeffecients1storderButton  matlab.ui.control.Button
        GravitationalConstantestEditField  matlab.ui.control.NumericEditField
        GravitationalConstantestEditFieldLabel  matlab.ui.control.Label
        MaxIterationsEditField          matlab.ui.control.NumericEditField
        MaxIterationsEditFieldLabel     matlab.ui.control.Label
        secondsLabel                    matlab.ui.control.Label
        cmLabel                         matlab.ui.control.Label
        Period1EditField                matlab.ui.control.NumericEditField
        Period1EditFieldLabel           matlab.ui.control.Label
        Period2EditField                matlab.ui.control.NumericEditField
        Period2EditFieldLabel           matlab.ui.control.Label
        Period3EditField                matlab.ui.control.NumericEditField
        Period3EditFieldLabel           matlab.ui.control.Label
        Period4EditField                matlab.ui.control.NumericEditField
        Period4EditFieldLabel           matlab.ui.control.Label
        Length4EditField                matlab.ui.control.NumericEditField
        Length4EditFieldLabel           matlab.ui.control.Label
        Length3EditField                matlab.ui.control.NumericEditField
        Length3EditFieldLabel           matlab.ui.control.Label
        Length2EditField                matlab.ui.control.NumericEditField
        Length2Label                    matlab.ui.control.Label
        Length1EditField                matlab.ui.control.NumericEditField
        Length1Label                    matlab.ui.control.Label
        CalculateModelButton            matlab.ui.control.Button
        AverageLoadedPeriodEditField    matlab.ui.control.EditField
        AverageLoadedPeriodEditFieldLabel  matlab.ui.control.Label
        AverageMeasuredPeriodEditField  matlab.ui.control.EditField
        AverageMeasuredPeriodEditFieldLabel  matlab.ui.control.Label
        NthOrderModelDropDown           matlab.ui.control.DropDown
        NthOrderModelDropDownLabel      matlab.ui.control.Label
        MethodDropDown                  matlab.ui.control.DropDown
        MethodDropDownLabel             matlab.ui.control.Label
        RecordSwing2Button              matlab.ui.control.StateButton
        RecordSwing3Button              matlab.ui.control.StateButton
        Lamp_4                          matlab.ui.control.Lamp
        Lamp_4Label                     matlab.ui.control.Label
        Lamp_3                          matlab.ui.control.Lamp
        Lamp_3Label                     matlab.ui.control.Label
        Lamp_2                          matlab.ui.control.Lamp
        Lamp_2Label                     matlab.ui.control.Label
        Lamp                            matlab.ui.control.Lamp
        Label                           matlab.ui.control.Label
        LoadedFilteredDataLabel         matlab.ui.control.Label
        LoadedRawDataLabel              matlab.ui.control.Label
        MeasuredFilteredDataLabel       matlab.ui.control.Label
        MeasuredRawDataLabel            matlab.ui.control.Label
        QuickInitButton                 matlab.ui.control.Button
        RecordSwing1Button              matlab.ui.control.StateButton
        InitializeArduinoButton         matlab.ui.control.Button
        BadDataLamp                     matlab.ui.control.Lamp
        BadDataLampLabel                matlab.ui.control.Label
        EchoPinEditField                matlab.ui.control.EditField
        EchoPinEditFieldLabel           matlab.ui.control.Label
        TriggerPinEditField             matlab.ui.control.EditField
        TriggerPinEditFieldLabel        matlab.ui.control.Label
        PortEditField                   matlab.ui.control.EditField
        PortEditFieldLabel              matlab.ui.control.Label
        Measure7secondsButton           matlab.ui.control.Button
        ResetGraphButton                matlab.ui.control.Button
        GoodDataLamp                    matlab.ui.control.Lamp
        GoodDataLampLabel               matlab.ui.control.Label
        UIAxes3                         matlab.ui.control.UIAxes
        UIAxes2                         matlab.ui.control.UIAxes
        UIAxes                          matlab.ui.control.UIAxes
    end

    %*****************************************************************************************%
    %                            Project 2 (Theory of Pendulums)                              %
    %                                                                                         %
    %            Names: Alfarook Saleh %60, Marissa Proctor %20, Hussein Bazzi %20            %
    %                            Class: ECE 3040 Numerical Methods                            %
    %                                Professor: Abhilash Pandya                               %
    %                                   Date: 11/8/2021                                       %
    %                                                                                         %
    % Project 1 Link: https://www.youtube.com/watch?v=wV6XSgt2Cnw&ab_channel=AlfarookSaleh    %
    %                                                                                         %
    % Project 2 Link: https://www.youtube.com/watch?v=w-J1FyQOHM0&ab_channel=AlfarookSaleh    %
    %                                                                                         %
    %*****************************************************************************************%


    properties (Access = public)


        % Marissa: Empty variables that hardware or data can be assigned to for easy
        % access and storage

        Uno = [];
        ultraS = [];
        distanceData = [];
        timeData = [];
        buttonOn = 0;
        buttonOn2 = 0;
        buttonOn3 = 0;
        buttonOn4 = 0;
        line1 = [];
        line2 = [];
        line3 = [];
        line4 = [];
        methodLine = [];
        Dline = [];
        DDots = [];
        Dline2 = [];
        DDots2 = [];
        
        method = "Matrix Inverse";
        order = "3rd";


    end














    methods (Access = private)

        function AvgPeriod = getPeriod(app, time, position)                % Credit : Hussein Bazzi

            i = 1;                      % Initializing local variables
            j = 1;
            peak = 0;
            tPeak = [];
            pPeak = [];
            count = 1;
            oldSlope = 0;
            period = [];
            limit = 0;
            h = 0.001;

            c = size(position, 2);      % Getting the amount of data points of the position array

            
            delete(app.Dline)
            delete(app.DDots)
            app.DDots = [];
            hold (app.UIAxes2,'on');    
            graph = diff(position)/h;   % This line gets the derivative of the swing of the pendulum
            app.Dline = plot(app.UIAxes2, graph, 'r');  % Plotting the derivative of the swing data

            for n=1:c-1             % This loop finds all the zeros of the derivative data and put a red marker at that point
                if graph(1,n) == 0
                    app.DDots(n) = plot(app.UIAxes2, graph, 'o', 'MarkerFaceColor', 'red', 'MarkerIndices', n);
                end
            end


            while (i < size(time, 2))       % This while loop reads every data point of the inputted position and time data sets
                yp1 = position(i);          % and looks for a change in sign of the slope to find the peaks which in turn can
                xp1 = time(i);              % tell us what the period is.

                yp2 = position(i + 1);
                xp2 = time(i + 1);

                yDelta = yp2 - yp1;
                xDelta = xp2 - xp1;

                slope = xDelta * yDelta;

                if (slope >= 0) % Positive slope
                    sign = 1;
                else            % Negative slope
                    sign = 2;
                end


                if (oldSlope >= 0) % Positive slope
                    oSign = 1;
                else               % Negative slope
                    oSign = 2;
                end


                if (sign ~= oSign)          % If a sign change is detected, the position and time data at that point is recorded

                    if(limit == 0)
                        peak = peak + 1;
                        tPeak(1, count) = time(i + 1);
                        pPeak(1, count) = position(i + 1);
                        count = count + 1;
                        limit = 4;
                    end

                end

                if (limit > 0)              % This limit variable prevents recording another peak right after a peak was recorded
                    limit = limit - 1;      % and helps eliminate bad data by ignoring false peaks
                end

                oldSlope = slope;


                i = i + 1;
            end
            while (j < size(tPeak,2) - 1)       % Minus 1 to prevent going above the range
                if (rem(j , 2) ~= 0)
                    period(1, j) = abs(tPeak(j + 2) - tPeak(j));    % Only gets odd indexes
                end
                j = j + 1;
            end

            
            AvgPeriod = (sum(period)/size(period, 2) * 2);

        end

        
        
        
        
        
        
        
        
        
        
        
        
        
        function AvgPeriod = getPeriod2(app, time, position)            % Credit: Hussein Bazzi

            i = 1;                      % Initializing local variables
            j = 1;
            peak = 0;
            tPeak = [];
            pPeak = [];
            count = 1;
            oldSlope = 0;
            period = [];
            limit = 0;
            h = 0.001;

            c = size(position, 2);      % Getting the amount of data points of the position array         
            
            
            delete(app.Dline2)
            delete(app.DDots2)
            app.DDots2 = [];
            hold (app.UIAxes2, 'on');
            graph = diff(position)/h;   % This line gets the derivative of the swing of the pendulum
            app.Dline2 = plot(app.UIAxes2, graph, 'k');  % Plotting the derivative of the swing data

            for n=1:c-1             % This loop finds all the zeros of the derivative data and put a red marker at that point
                if graph(1,n) == 0
                    app.DDots2(n) = plot(app.UIAxes2, graph, 'o', 'MarkerFaceColor', 'black', 'MarkerIndices', n);
                end
            end


            while (i < size(time, 2))       % This while loop reads every data point of the inputted position and time data sets
                yp1 = position(i);          % and looks for a change in sign of the slope to find the peaks which in turn can
                xp1 = time(i);              % tell us what the period is.

                yp2 = position(i + 1);
                xp2 = time(i + 1);

                yDelta = yp2 - yp1;
                xDelta = xp2 - xp1;

                slope = xDelta * yDelta;

                if (slope >= 0) % Positive slope
                    sign = 1;
                else            % Negative slope
                    sign = 2;
                end


                if (oldSlope >= 0) % Positive slope
                    oSign = 1;
                else               % Negative slope
                    oSign = 2;
                end


                if (sign ~= oSign)          % If a sign change is detected, the position and time data at that point is recorded

                    if(limit == 0)
                        peak = peak + 1;
                        tPeak(1, count) = time(i + 1);
                        pPeak(1, count) = position(i + 1);
                        count = count + 1;
                        limit = 4;
                    end

                end

                if (limit > 0)              % This limit variable prevents recording another peak right after a peak was recorded
                    limit = limit - 1;      % and helps eliminate bad data by ignoring false peaks
                end

                oldSlope = slope;


                i = i + 1;
            end
            while (j < size(tPeak,2) - 1)       % Minus 1 to prevent going above the range
                if (rem(j , 2) ~= 0)
                    period(1, j) = abs(tPeak(j + 2) - tPeak(j));    % Only gets odd indexes
                end
                j = j + 1;
            end

            
            AvgPeriod = (sum(period)/size(period, 2) * 2);

        end























        function [modelEquation, vectors] = MatrixInverse(app, Matrix, RHS)     % Credit: Marissa Proctor

            [rows, columns] = size(Matrix);

            vectors = inv(Matrix)*RHS;                                          % Meat and potatoes of this numerical method. The vector matrix is inverse of input matrix times the RHS.

            if rows == 2
                modelEquation = @(L) vectors(1,1)*L + vectors(2,1);
            elseif rows == 3
                modelEquation = @(L) vectors(1,1)*(L^2) + vectors(2,1)*(L) + vectors(3,1); % Forming a model equation to be plotted
            elseif rows == 4
                modelEquation = @(L) vectors(1,1)*L.^3 + vectors(2,1)*L.^2 + vectors(3,1)*L + vectors(4,1);   % Forming a model equation to be plotted

            end


            delete(app.methodLine)                                               % Creating a handle called methodLine to be able to delete old plots and replace with new plot

            if rows == 2
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,1) Matrix(2,1)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
            elseif rows == 3
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,2) Matrix(3,2)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
            elseif rows == 4
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,3) Matrix(4,3)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.

            end
        end


















        function [modelEquation, X, UpperM] = LU_Decomposition(app, Matrix, RHS)   % Credit: Marissa Proctor 

            [rows, columns] = size(Matrix);                          % Getting the size of the input matrix

            M = Matrix;                                              % This line is so the input matrix isn't changed by the function. Instead, a new matrix is formed.

            if rows~=columns                                         % Necessary check to see if the matrix is square. The method will not work otherwise.
                error('Matrix must be Square')
            end

            LowerM = eye(rows);                                      % Creates identity matrix of input matrix

            for i = 1:rows-1       % Nested loop that starts at the first value in the second row then
                % goes down the column, each time increasing the
                % number of values skipped from the top of the next
                % column by one and stops before the last column. Effectively, this is
                % how we get the Upper/Lower Matrix in the end
                for j = i+1:rows


                    LU_ratio = M(j,i) / M(i,i);     % Getting the ratio that we multiply a row with by dividing the number we're trying to make zero by the number above it.
                    % This ratio will be used later to
                    % get the Lower Matrix

                    M(j,i:rows) = M(j,i:rows) - LU_ratio*M(i,i:rows); % This line is the meat and potatoes of this method and it is how we get the Upper Matrix.
                    % It takes the entire row, starting from the second row, and
                    % subtracts it by the multiple of the first row and the LU_ratio
                    % found previously. Then this process repeats (from line 17) down the first column, getting a new LU_ratio each time, until
                    % column one is all zeros except for the first skipped value
                    % (because the loop starts at the second row). Now, this process
                    % repeats (from line 15) and gets a second column full of zeros
                    % except for the first two skipped values (because now the loop
                    % from line 17 starts at the third row). This continues until all
                    % columns are completely affected.



                    LowerM(j,i) = LU_ratio;         % The Lower matrix is just the identity matrix of the input matrix with
                    % the ratios in the lower half in place of the zeros when
                    % finding the Upper matrix
                end
            end

            UpperM = M;          % After going through the nested loop, M is transformed into the Upper Triangular Matrix

            Z = LowerM\RHS;        % Taking the inverse of LowerMatrix and multiplying it by the C matrix. MATLAB suggested this way was better

            X = UpperM\Z;        % Taking the inverse of UpperMatrix and multiplying it by the Z matrix.


            if rows == 2
                modelEquation = @(t) X(1,1)*t + X(2,1);
            elseif rows == 3
                modelEquation = @(t) X(1,1)*t.^2 + X(2,1)*t + X(3,1);   % Forming a model equation to be plotted
            elseif rows == 4
                modelEquation = @(t) X(1,1)*t.^3 + X(2,1)*t.^2 + X(3,1)*t + X(4,1);   % Forming a model equation to be plotted

            end

            delete(app.methodLine)                                               % Creating a handle called methodLine to be able to delete old plots and replace with new plot

            if rows == 2
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,1) Matrix(2,1)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
            elseif rows == 3
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,2) Matrix(3,2)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
            elseif rows == 4
                app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,3) Matrix(4,3)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.

            end
        end














        function [DDMatrix, DDRHS] = DDSorter(app, MatrixA, RHS)            % Credit: Alfarook Saleh

            [rows, columns] = size(MatrixA);
            M = [MatrixA RHS];
            count = 0;
            flag = 0;

            if rows~=columns    % This is a necessary check that maxes sure the inputted Matrix is square
                error('Matrix is not Square');
            end

            N = zeros(rows, 1); % Creates one column of zeros based on the number of rows inputted

            for i = 1:rows
                for j = 1:columns
                    N(i) = N(i) + (abs(M(i,j)));    % This nested loop adds the absolute value of all the numbers in a row together, stores it into the zero matrix N(i), and repeats for all rows inputted
                end
            end

            for i = 1:rows                                   % Nested loop that goes through all the indices in the first row of a matrix...

                for j = i:columns                            % ...and skips a value at the start of a new row depending on how many complete loops have gone by

                    if (abs(M(j,i))) >= N(j) - (abs(M(j,i))) % This line finds the index that is larger or equal to the absolute sum of the other numbers in its row and goes top to bottom instead of left to right (A.K.A, Diagonal Dominance Sorter)

                        tempM = M(i,:);                 % Making a temporary matrix to hold the values of the row being swapped

                        M(i,:) = M(j,:);           % Swapping a row with the correct diagonally dominant row

                        M(j,:) = tempM;                 % Replacing the correct diagonally dominant row used with the swapped row

                        tempN = N(i);                        % Making a temporary matrix to hold the sum of the row absolute value being swapped

                        N(i) = N(j);                         % Replacing the absolute sum of the swapped row with its corresponding row

                        N(j) = tempN;                        % Replacing the absolute sum of the row used to swap. This is so the loop doesn't mix up the absolute sums of the matrix rows

                        count = count + 1;                   % A check to see if there even IS an absolute value in the row that is larger than the absolute sum of the of the other values in the same row.
                        % If not, it's impossible for the matrix to be diagonally dominant.

                        if abs(M(j,i)) > N(j) - abs(M(j,i)) % A check for strictly diagonally dominant Matrix / will converge
                            flag = 1;
                        end
                    end
                end
            end

            DDMatrix = M(1:rows, 1:columns);     % I have to specify here because M is a matrix with an extra column. This line ignores the final column
            DDRHS = M(1:rows, end);

            if count ~= rows
                error('Inputted matrix CANNOT be made diagonally dominant') % A check that will not output the matrix if it's not sorted for diagonal dominance
            elseif abs(M(1,1)) >= N(1) - abs(M(1,1)) && abs(M(2,1)) >= N(2) - abs(M(2,1))
                error('Inputted matrix CANNOT be made diagonally dominant') % A check that will not output the matrix if it's not sorted for diagonal dominance
            elseif count == rows && flag == 0
                disp('Not strict dominance, may or may not converge')
            elseif count == rows && flag == 1
                disp('STRICTLY diagonally dominant, will converge')
            end
        end

















        function [modelEquation, maxARAE, x1, x2] = GaussSeidel1st(app, Matrix, RHS, RHSGuesses, maxIterations)         % Credit: Alfarook Saleh

            M = Matrix;   % Taking user input from GUI and forming a matrix template
            Guess = RHSGuesses;                                         % Taking user input from GUI and making a matrix. This has the added benefit of not changing the inputted values

            [DDM, DDRHS] = app.DDSorter(M, RHS);              % Calling the DDSorter function to sort the matrix into a diagonally dominant form

            C = DDRHS;

            x1(1) = Guess(1,1); x2(1) = Guess(2,1);       % Using initial guesses inputted

            for i = 1:maxIterations

                oldx1(i) = x1(i);                         % Saving the previous values for Absolute Relative Approximate Error (ARAE)
                oldx2(i) = x2(i);

                x1(i + 1) = (C(1,1) - (DDM(1,2)*x2(i)) - (DDM(1,3)*x3(i)))/DDM(1,1);        % Rewriting each equation of the DDM matrix to get the coeffecient x1 on one side and everything else on the RHS. Repeat for each coeffecient

                x2(i + 1) = (C(2,1) - (DDM(2,1)*x1(i + 1)) - (DDM(2,3)*x3(i)))/DDM(2,2);

                ARAE1(i) = abs((x1(i + 1) - oldx1(i))/x1(i + 1))*100;                       % Taking the Absolute Relative Approximate Error of each coeffecient after every iteration
                ARAE2(i) = abs((x2(i + 1) - oldx2(i))/x2(i + 1))*100;

                temp = [ARAE1(i);ARAE2(i)];                                        % Finding the Maximum Absolute Relative Approximate Error out of the coeffecients every iteration
                maxARAE(i) = max(temp);

                if i == maxIterations                            % A check to make sure the loop hasn't passed the maximum iteration or if we are in our desired error tolerance
                    app.iter = i;
                    break
                end
                app.iter = i;
            end

            modelEquation = @(L) x1(app.iter+1)*L + x2(app.iter+1);

            delete(app.methodLine)                                               % Creating a handle called methodLine to be able to delete old plots and replace with new plot

            app.methodLine = fplot(app.UIAxes3, modelEquation, [Matrix(1,1) Matrix(2,1)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.

        end






















    function [modelEquation, maxARAE, x1, x2, x3] = GaussSeidel2nd(app, Matrix, RHS, RHSGuesses, maxIterations)         % Credit: Alfarook Saleh

        M = Matrix;   % Taking user input from GUI and forming a matrix template
        Guess = RHSGuesses;                                         % Taking user input from GUI and making a matrix. This has the added benefit of not changing the inputted values

        [DDM, DDRHS] = app.DDSorter(M, RHS);              % Calling the DDSorter function to sort the matrix into a diagonally dominant form

        C = DDRHS;

        x1(1) = Guess(1,1); x2(1) = Guess(2,1); x3(1) = Guess(3,1);       % Using initial guesses inputted

        for i = 1:maxIterations

            oldx1(i) = x1(i);                         % Saving the previous values for Absolute Relative Approximate Error (ARAE)
            oldx2(i) = x2(i);
            oldx3(i) = x3(i);

            x1(i + 1) = (C(1,1) - (DDM(1,2)*x2(i)) - (DDM(1,3)*x3(i)))/DDM(1,1);        % Rewriting each equation of the DDM matrix to get the coeffecient x1 on one side and everything else on the RHS. Repeat for each coeffecient

            x2(i + 1) = (C(2,1) - (DDM(2,1)*x1(i + 1)) - (DDM(2,3)*x3(i)))/DDM(2,2);

            x3(i + 1) = (C(3,1) - (DDM(3,1)*x1(i + 1)) - (DDM(3,2)*x2(i + 1)))/DDM(3,3);

            ARAE1(i) = abs((x1(i + 1) - oldx1(i))/x1(i + 1))*100;                       % Taking the Absolute Relative Approximate Error of each coeffecient after every iteration
            ARAE2(i) = abs((x2(i + 1) - oldx2(i))/x2(i + 1))*100;
            ARAE3(i) = abs((x3(i + 1) - oldx3(i))/x3(i + 1))*100;

            temp = [ARAE1(i);ARAE2(i);ARAE3(i)];                                        % Finding the Maximum Absolute Relative Approximate Error out of the coeffecients every iteration
            maxARAE(i) = max(temp);

            if i == maxIterations                            % A check to make sure the loop hasn't passed the maximum iteration or if we are in our desired error tolerance
                app.iter = i;
                break
            end
            app.iter = i;
        end

        modelEquation = @(L) x1(app.iter+1)*(L^.2) + x2(app.iter+1)*L + x3(app.iter+1);

        delete(app.methodLine)                                               % Creating a handle called methodLine to be able to delete old plots and replace with new plot

        app.methodLine = fplot(app.UIAxes3, modelEquation, [DDM(1,2) DDM(3,2)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
    end


















    function [modelEquation, maxARAE, x1, x2, x3, x4] = GaussSeidel3rd(app, Matrix, RHS, RHSGuesses, maxIterations)         % Credit: Alfarook Saleh

        M = Matrix;   % Taking user input from GUI and forming a matrix template
        Guess = RHSGuesses;                                         % Taking user input from GUI and making a matrix. This has the added benefit of not changing the inputted values


        [DDM, DDRHS] = app.DDSorter(M, RHS);              % Calling the DDSorter function to sort the matrix into a diagonally dominant form

        C = DDRHS;

        x1(1) = Guess(1,1); x2(1) = Guess(2,1); x3(1) = Guess(3,1); x4(1) = Guess(4,1);       % Using initial guesses inputted

        for i = 1:maxIterations

            oldx1(i) = x1(i);                         % Saving the previous values for Absolute Relative Approximate Error (ARAE)
            oldx2(i) = x2(i);
            oldx3(i) = x3(i);
            oldx4(i) = x4(i);

            x1(i + 1) = (C(1,1) - (DDM(1,2)*x2(i)) - (DDM(1,3)*x3(i)) - (DDM(1,4)*x4(i)))/DDM(1,1);        % Rewriting each equation of the DDM matrix to get the coeffecient x1 on one side and everything else on the RHS. Repeat for each coeffecient

            x2(i + 1) = (C(2,1) - (DDM(2,1)*x1(i + 1)) - (DDM(2,3)*x3(i)) - (DDM(2,4)*x4(i)))/DDM(2,2);

            x3(i + 1) = (C(3,1) - (DDM(3,1)*x1(i + 1)) - (DDM(3,2)*x2(i + 1)) - (DDM(3,4)*x4(i)))/DDM(3,3);

            x4(i + 1) = (C(4,1) - (DDM(4,1)*x1(i + 1)) - (DDM(4,2)*x2(i + 1)) - (DDM(4,3)*x3(i + 1)))/DDM(4,4);


            ARAE1(i) = abs((x1(i + 1) - oldx1(i))/x1(i + 1))*100;                       % Taking the Absolute Relative Approximate Error of each coeffecient after every iteration
            ARAE2(i) = abs((x2(i + 1) - oldx2(i))/x2(i + 1))*100;
            ARAE3(i) = abs((x3(i + 1) - oldx3(i))/x3(i + 1))*100;
            ARAE4(i) = abs((x4(i + 1) - oldx4(i))/x4(i + 1))*100;

            temp = [ARAE1(i);ARAE2(i);ARAE3(i);ARAE4(i)];                                        % Finding the Maximum Absolute Relative Approximate Error out of the coeffecients every iteration
            maxARAE(i) = max(temp);

            if i == maxIterations                            % A check to make sure the loop hasn't passed the maximum iteration or if we are in our desired error tolerance
                app.iter = i;
                break
            end
            app.iter = i;
        end

        modelEquation = @(L) x1(app.iter+1)*(L^.3) + x2(app.iter+1)*(L^.2) + x3(app.iter+1)*(L) + x4(app.iter+1);

        delete(app.methodLine)                                               % Creating a handle called methodLine to be able to delete old plots and replace with new plot

        app.methodLine = fplot(app.UIAxes3, modelEquation, [DDM(1,3) DDM(4,3)]);                            % Plotting the model equation on the bounds of the first and last length inputted. The graph is only effective at this range.
    end
    

    
    
    
    
    
    
    
    
    
    
    
    
    
        
end








    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: InitializeArduinoButton
        function StartUno(app, event)
            try
                port = app.PortEditField.Value;                     % Marissa: Taking user inputs and saving them to easier-to-use variables
                triggerPin = app.TriggerPinEditField.Value;
                echoPin = app.EchoPinEditField.Value;

                app.Uno = arduino(port, 'Uno', 'Libraries', 'Ultrasonic'); % Marissa: Assigning the arduino to the 'Uno' array for easy access

            catch

                msgbox('Arduino failed');           % Marissa: Msgboxes are put in a way so that if initialization fails, the user can determine where it failed (Arduino or sensor)

            end

            try
                app.ultraS = app.Uno.ultrasonic(triggerPin, echoPin);       % Marissa: Assigning the ultrasonic sensor to 'ultraS'

                writeDigitalPin(app.Uno, 'D7', 1);                          % Marissa: Activating pins D7 and D6 which turns on the connected LEDs
                writeDigitalPin(app.Uno, 'D6', 1);

                msgbox ('Ardiono and Ultrasound ready');

            catch

                msgbox('Arduino Ready BUT Ultrasound failed');

                return;

            end

        end

        % Button pushed function: Measure7secondsButton
        function Measure7secondsButtonPushed(app, event)

            y = [];                % Alfarook: Initializing the y and t arrays.
            t = [];

            y2 = [];               % Alfarook: Initializing the y2 and t2 arrays.
            t2 = [];

            hold (app.UIAxes, 'on')     % Alfarook: This function makes everything graphed onto the UIAxes figure stay put instead of resetting when a new line is plotted

            count = 1;                  % Alfarook: Making a counting variable. This is needed for saving the data to the array and can be used to count number of iterations
            count2 = 1;                 % Alfarook: Making a counting variable. This is needed for saving the data to the array and can be used to count number of iterations

            tic

            while (toc < 7)                                           % Alfarook: keeps the loop going for 3 seconds
                app.distanceData = app.ultraS.readDistance();         % Alfarook: assigning ultrasound readings to the distanceData array
                app.timeData = toc;                                   % Alfarook: assigning the time at which each reading is taken to the timeData array

                y(count) = [app.distanceData];                      % Alfarook: Saving sensor data into the 'y' array.
                t(count) = [app.timeData];                          % Alfarook: Same as above line except for time data.

                if (app.distanceData == inf)                        % Alfarook: An if function that filters out 'inf' values by only saving data that isn't an 'inf' value

                else

                    y2(count2) = [app.distanceData];                      % Alfarook: Saving sensor data into the 'y2' array.
                    t2(count2) = [app.timeData];                          % Alfarook: Same as above line except for time data.
                    count2 = count2 + 1;                                    % Alfarook: Incrementing the count as the loop is repeated

                end


                if (app.distanceData > 0.3)                         % Alfarook: An if function that determines if the acquired distance data is within a good range (0.3 meters)
                    writeDigitalPin(app.Uno, 'D7', 1);              % or not and lights LEDs correspondingly
                    writeDigitalPin(app.Uno, 'D6', 0);
                    app.BadDataLamp.Enable = 'on';
                    app.GoodDataLamp.Enable = 'off';
                else
                    writeDigitalPin(app.Uno, 'D7', 0);
                    writeDigitalPin(app.Uno, 'D6', 1);
                    app.BadDataLamp.Enable = 'off';
                    app.GoodDataLamp.Enable = 'on';
                end


                count = count + 1;                                  % Alfarook: Incrementing the count as the loop is repeated


                delete(app.line1);  % Alfarook: If plotting more than once without a handle or name for the plot,
                % the old plot becomes impossible to erase because its name is gone and can't be referenced
                % Therefore, one must name the plot and
                % delete it before making a new one else it will stay permanently


                app.line1 = plot(app.UIAxes,t, y, 'b');      % Alfarook: Plotting the raw distance and time values onto the app's graph with the color blue and naming it 'app.line1' for future reference

            end

            writeDigitalPin(app.Uno, 'D7', 0);
            writeDigitalPin(app.Uno, 'D6', 0);
            app.BadDataLamp.Enable = 'off';
            app.GoodDataLamp.Enable = 'off';

            y2 = medfilt1(y2, 3);                            % Alfarook: Filtering the data to remove spikes using medfilt1. Takes the median of 3 entries of data

            delete(app.line2);                               % Alfarook: Same as line 160

            app.line2 = plot(app.UIAxes,t2, y2, 'g--');      % Alfarook: Plotting the filtered distance and time values onto the app's graph with a dashed green line and naming it 'app.line2' for future reference


            if (app.buttonOn)

                save ('PendulumData', 't', 'y');     % Hussein:  A save function that becomes enabled when the 'Record Data 1' switch is turned on. This then becomes the raw data that is used when
                % 'Pendulum Data (6in.)' is pushed in the 'load' menu.

                save ('PendulumDataF', 't2', 'y2');  % Hussein:  A save function that becomes enabled when the 'Record Data 1' switch is turned on. This then becomes the filtered data that is used when
                % 'Pendulum Data (6in.)' is pushed in the 'load' menu.
            end
            if (app.buttonOn2)

                save ('PendulumData2', 't', 'y');    % Hussein:  A save function that becomes enabled when the 'Record Data 2' switch is turned on. This then becomes the raw data that is used when
                % 'Pendulum Data (1ft.)' is pushed in the 'load' menu.

                save ('PendulumData2F', 't2', 'y2'); % Hussein:  A save function that becomes enabled when the 'Record Data 2' switch is turned on. This then becomes the filtered data that is used when
                % 'Pendulum Data (1ft.)' is pushed in the 'load' menu.
            end
            if (app.buttonOn3)

                save ('PendulumData3', 't', 'y');    % Hussein:  A save function that becomes enabled when the 'Record Data 3' switch is turned on. This then becomes the raw data that is used when
                % 'Pendulum Data (1ft. 6in.)' is pushed in the 'load' menu.

                save ('PendulumData3F', 't2', 'y2'); % Hussein:  A save function that becomes enabled when the 'Record Data 3' switch is turned on. This then becomes the filtered data that is used when
                % 'Pendulum Data (1ft. 6in.)' is pushed in the 'load' menu.

            end
            if (app.buttonOn4)

                save ('PendulumData4', 't', 'y');    % Hussein:  A save function that becomes enabled when the 'Record Data 3' switch is turned on. This then becomes the raw data that is used when
                % 'Pendulum Data (1ft. 6in.)' is pushed in the 'load' menu.

                save ('PendulumData4F', 't2', 'y2'); % Hussein:  A save function that becomes enabled when the 'Record Data 3' switch is turned on. This then becomes the filtered data that is used when
                % 'Pendulum Data (1ft. 6in.)' is pushed in the 'load' menu.

            end
            
            app.AverageMeasuredPeriodEditField.Value = num2str(getPeriod2(app, t2, y2));


        end

        % Button pushed function: ResetGraphButton
        function ResetGraphButtonPushed(app, event)
            delete(app.line1);          % Hussein: Deletes the raw curve plotted when measuring data through the sensor
            delete(app.line2);          % Hussein: Deletes the filtered curve plotted when measuring data through the sensor
            delete(app.line3);          % Hussein: Deletes the raw curve loaded from previously measured curve
            delete(app.line4);          % Hussein: Deletes the filtered curve loaded from previously measured curve

        end

        % Menu selected function: SwingData16inMenu
        function Data1MenuSelected(app, event)
            load PendulumData.mat;              % Hussein: Loads the saved raw data from a previously measured graph
            load PendulumDataF.mat;             % Hussein: Loads the saved filtered data from a previously measured graph
            hold (app.UIAxes, 'on')
            delete(app.line3);                   % Hussein: Same thing explained in line 160
            app.line3 = plot(app.UIAxes,t,y, 'm' );     % Hussein: Different plot names were necessary in order to differentiate between the 4 graphed curves. This curve is colored magenta
            delete(app.line4);
            app.line4 = plot(app.UIAxes,t2,y2, 'c--');  % Hussein: This curve is colored cyan and is dashed
            app.AverageLoadedPeriodEditField.Value = num2str(getPeriod(app,t2,y2));  % Hussein: constantly shows the average period of the loaded curve

        end

        % Menu selected function: SwingData212inMenu
        function Data2MenuSelected(app, event)
            load PendulumData2.mat;              % Hussein: Loads the saved raw data from a previously measured graph
            load PendulumData2F.mat;             % Hussein: Loads the saved filtered data from a previously measured graph
            hold (app.UIAxes, 'on')
            delete(app.line3);                   % Hussein: Same thing explained in line 160
            app.line3 = plot(app.UIAxes,t,y, 'm' );     % Hussein: Different plot names were necessary in order to differentiate between the 4 graphed curves. This curve is colored magenta
            delete(app.line4);
            app.line4 = plot(app.UIAxes,t2,y2, 'c--');  % Hussein: This curve is colored cyan and is dashed
            app.AverageLoadedPeriodEditField.Value = num2str(getPeriod(app,t2,y2));      % Hussein: constantly shows the average period of the loaded curve

        end

        % Menu selected function: SwingData318inMenu
        function Data3MenuSelected(app, event)
            load PendulumData3.mat;              % Hussein: Loads the saved raw data from a previously measured graph
            load PendulumData3F.mat;             % Hussein: Loads the saved filtered data from a previously measured graph
            hold (app.UIAxes, 'on')
            delete(app.line3);                   % Hussein: Same thing explained in line 160
            app.line3 = plot(app.UIAxes,t,y, 'm' );     % Hussein: Different plot names were necessary in order to differentiate between the 4 graphed curves. This curve is colored magenta
            delete(app.line4);
            app.line4 = plot(app.UIAxes,t2,y2, 'c--');  % Hussein: This curve is colored cyan and is dashed
            app.AverageLoadedPeriodEditField.Value = num2str(getPeriod(app,t2,y2));      % Hussein: constantly shows the average period of the loaded curve

        end

        % Menu selected function: SwingData424inMenu
        function SwingData424inMenuSelected(app, event)
            load PendulumData4.mat;              % Hussein: Loads the saved raw data from a previously measured graph
            load PendulumData4F.mat;             % Hussein: Loads the saved filtered data from a previously measured graph
            hold (app.UIAxes, 'on')
            delete(app.line3);                   % Hussein: Same thing explained in line 160
            app.line3 = plot(app.UIAxes,t,y, 'm' );     % Hussein: Different plot names were necessary in order to differentiate between the 4 graphed curves. This curve is colored magenta
            delete(app.line4);
            app.line4 = plot(app.UIAxes,t2,y2, 'c--');  % Hussein: This curve is colored cyan and is dashed
            app.AverageLoadedPeriodEditField.Value = num2str(getPeriod(app,t2,y2));          % Hussein: constantly shows the average period of the loaded curve           
        end

        % Menu selected function: stOrderMenu
        function stOrderMenuSelected(app, event)
            load Coeffecients_1st_order.mat;        % Hussein: Loads the saved variable in the 'Coeffecients_1st_order.mat' file and displays them on their corresponding edit fields

            app.Length1EditField.Value = L1;
            app.Length2EditField.Value = L2;


            app.Period1EditField.Value = P1;
            app.Period2EditField.Value = P2;
        end

        % Menu selected function: ndOrderMenu
        function ndOrderMenuSelected(app, event)
            load Coeffecients_2nd_order.mat;         % Hussein: Loads the saved variable in the 'Coeffecients_2nd_order.mat' file and displays them on their corresponding edit fields

            app.Length1EditField.Value = L1;
            app.Length2EditField.Value = L2;
            app.Length3EditField.Value = L3;

            app.Period1EditField.Value = P1;
            app.Period2EditField.Value = P2;
            app.Period3EditField.Value = P3;
        end

        % Menu selected function: rdOrderMenu
        function rdOrderMenuSelected(app, event)
            load Coeffecients_3rd_order.mat;         % Hussein: Loads the saved variable in the 'Coeffecients_3rd_order.mat' file and displays them on their corresponding edit fields

            app.Length1EditField.Value = L1;
            app.Length2EditField.Value = L2;
            app.Length3EditField.Value = L3;
            app.Length4EditField.Value = L4;

            app.Period1EditField.Value = P1;
            app.Period2EditField.Value = P2;
            app.Period3EditField.Value = P3;
            app.Period4EditField.Value = P4;
        end

        % Value changed function: RecordSwing1Button
        function RecordSwing1ButtonValueChanged(app, event)
            app.buttonOn = app.RecordSwing1Button.Value; % Hussein: A function that is turned on or off. Used for determining when to save a measured graph

        end

        % Value changed function: RecordSwing2Button
        function RecordSwing2ButtonValueChanged(app, event)
            app.buttonOn2 = app.RecordSwing2Button.Value; % Hussein: A function that is turned on or off. Used for determining when to save a measured graph

        end

        % Value changed function: RecordSwing3Button
        function RecordSwing3ButtonValueChanged(app, event)
            app.buttonOn3 = app.RecordSwing3Button.Value; % Hussein: A function that is turned on or off. Used for determining when to save a measured graph

        end

        % Value changed function: RecordSwing4Button
        function RecordSwing4ButtonValueChanged(app, event)
            app.buttonOn4 = app.RecordSwing4Button.Value;   % Hussein: A function that is turned on or off. Used for determining when to save a measured graph
            
        end

        % Button pushed function: RecordCoeffecients1storderButton
        function RecordCoeffecients1storderButtonPushed(app, event)
            L1 = app.Length1EditField.Value;                % Hussein: A button that saves the corresponding values to the 'Coeffecients_ist_order.mat' file when clicked on.
            L2 = app.Length2EditField.Value;


            P1 = app.Period1EditField.Value;
            P2 = app.Period2EditField.Value;


            save ('Coeffecients_1st_order', 'L1', 'L2', 'P1', 'P2' ); 

            
        end

        % Button pushed function: RecordCoeffecients2ndorderButton
        function RecordCoeffecients2ndorderButtonPushed(app, event)
            L1 = app.Length1EditField.Value;                % Hussein: A button that saves the corresponding values to the 'Coeffecients_ist_order.mat' file when clicked on.
            L2 = app.Length2EditField.Value;
            L3 = app.Length3EditField.Value;


            P1 = app.Period1EditField.Value;
            P2 = app.Period2EditField.Value;
            P3 = app.Period3EditField.Value;

            save ('Coeffecients_2nd_order', 'L1', 'L2',"L3","P1","P2","P3")
            
        end

        % Button pushed function: RecordCoeffecients3rdorderButton
        function RecordCoeffecients3rdorderButtonPushed(app, event)
            L1 = app.Length1EditField.Value;            % Hussein: A button that saves the corresponding values to the 'Coeffecients_ist_order.mat' file when clicked on.
            L2 = app.Length2EditField.Value;
            L3 = app.Length3EditField.Value;
            L4 = app.Length4EditField.Value;

            P1 = app.Period1EditField.Value;
            P2 = app.Period2EditField.Value;
            P3 = app.Period3EditField.Value;
            P4 = app.Period4EditField.Value;

            save ('Coeffecients_3rd_order', 'L1', 'L2',"L3",'L4', "P1","P2","P3", 'P4')
            
        end

        % Value changed function: MethodDropDown
        function MethodDropDownValueChanged(app, event)
                                                         % Credit: Alfarook Saleh
            
            app.method = app.MethodDropDown.Value;       % app.method is necessary to be referenced in other callback functions easily. Same with 'app.order' below in line 1098

            if (app.method == "Gauss Seidel")            % This if statement hide the iterations edit field if not in Gauss Seidel mode
                app.MaxIterationsEditField.Visible = 1;
                app.MaxIterationsEditFieldLabel.Visible = 1;
            else
                app.MaxIterationsEditField.Visible = 0;
                app.MaxIterationsEditFieldLabel.Visible = 0;
            end

        end

        % Value changed function: NthOrderModelDropDown
        function NthOrderModelDropDownValueChanged(app, event)
            app.order = app.NthOrderModelDropDown.Value;                        % Credit: Alfarook Saleh
                                                                                % This function ensures the user does not input more arguments
                                                                                % than they need to and be comfused with the result by making
                                                                                % unused fields disappear. The code is pretty self-explanatory

            if (app.method == "Matrix Inverse")

                if (app.order == "1st")
                    app.Length3EditField.Visible = 0;
                    app.Period3EditField.Visible = 0;
                    app.Length3EditFieldLabel.Visible = 0;
                    app.Period3EditFieldLabel.Visible = 0;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;

                elseif (app.order == "2nd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;


                elseif (app.order == "3rd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 1;
                    app.Period4EditField.Visible = 1;
                    app.Length4EditFieldLabel.Visible = 1;
                    app.Period4EditFieldLabel.Visible = 1;


                end

            elseif (app.method == "LU Decomposition")

                if (app.order == "1st")
                    app.Length3EditField.Visible = 0;
                    app.Period3EditField.Visible = 0;
                    app.Length3EditFieldLabel.Visible = 0;
                    app.Period3EditFieldLabel.Visible = 0;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;


                elseif (app.order == "2nd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;


                elseif (app.order == "3rd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 1;
                    app.Period4EditField.Visible = 1;
                    app.Length4EditFieldLabel.Visible = 1;
                    app.Period4EditFieldLabel.Visible = 1;


                end
            elseif (app.method == "Gauss Seidel")

                if (app.order == "1st")
                    app.Length3EditField.Visible = 0;
                    app.Period3EditField.Visible = 0;
                    app.Length3EditFieldLabel.Visible = 0;
                    app.Period3EditFieldLabel.Visible = 0;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;


                elseif (app.order == "2nd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 0;
                    app.Period4EditField.Visible = 0;
                    app.Length4EditFieldLabel.Visible = 0;
                    app.Period4EditFieldLabel.Visible = 0;


                elseif (app.order == "3rd")
                    app.Length3EditField.Visible = 1;
                    app.Period3EditField.Visible = 1;
                    app.Length3EditFieldLabel.Visible = 1;
                    app.Period3EditFieldLabel.Visible = 1;
                    app.Length4EditField.Visible = 1;
                    app.Period4EditField.Visible = 1;
                    app.Length4EditFieldLabel.Visible = 1;
                    app.Period4EditFieldLabel.Visible = 1;

                end
            end

        end

        % Button pushed function: CalculateModelButton
        function CalculateModelButtonPushed(app, event)

            if (app.method == "Matrix Inverse")          % Credit: Alfarook      UI that takes user inputs and correctly uses the data in the way the user intends to
                if (app.order == "1st")                 % This is mostly rinse and repeated data so not much explaining needs to be done and the if statements are pretty self-explanatory.
                    L1 = app.Length1EditField.Value;     % The function takes user inputs, forms a matrix, and sends the matrix into the correct function method for processing
                    L2 = app.Length2EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;


                    InputM = [L1 , 1; L2 , 1];
                    InputRHS = [P1; P2];

                    app.MatrixInverse(InputM, InputRHS);


                elseif (app.order == "2nd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;


                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;

                    InputM = [(L1.^2) , L1 , 1; (L2.^2) , L2 , 1; (L3.^2) , L3 , 1];
                    InputRHS = [P1; P2; P3];

                    app.MatrixInverse(InputM, InputRHS);



                elseif (app.order == "3rd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;
                    L4 = app.Length4EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;
                    P4 = app.Period4EditField.Value;

                    InputM = [(L1.^3), (L1.^2) , L1 , 1; (L2.^3), (L2.^2) , L2 , 1; (L3.^3), (L3.^2) , L3 , 1; (L4.^3), (L4.^2), L4, 1];
                    InputRHS = [P1; P2; P3; P4];

                    app.MatrixInverse(InputM, InputRHS);

                end







            elseif (app.method == "LU Decomposition")
                if (app.order == "1st")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;


                    InputM = [L1 , 1; L2 , 1];
                    InputRHS = [P1; P2];

                    app.LU_Decomposition(InputM, InputRHS);



                elseif (app.order == "2nd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;


                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;

                    InputM = [(L1.^2) , L1 , 1; (L2.^2) , L2 , 1; (L3.^2) , L3 , 1];
                    InputRHS = [P1; P2; P3];

                    app.LU_Decomposition(InputM, InputRHS);


                elseif (app.order == "3rd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;
                    L4 = app.Length4EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;
                    P4 = app.Period4EditField.Value;

                    InputM = [(L1.^3), (L1.^2) , L1 , 1; (L2.^3), (L2.^2) , L2 , 1; (L3.^3), (L3.^2) , L3 , 1; (L4.^3), (L4.^2), L4, 1];
                    InputRHS = [P1; P2; P3; P4];

                    app.LU_Decomposition(InputM, InputRHS);


                end





            elseif (app.method == "Gauss Seidel")
                if (app.order == "1st")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    maxIterations = app.MaxIterationsEditField.Value;


                    InputM = [L1 , 1; L2 , 1];
                    InputRHS = [P1; P2];
                    Guess = [1.4, 1.4];

                    app.GaussSeidel1st(InputM, InputRHS, Guess, maxIterations);


                elseif (app.order == "2nd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;


                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;
                    maxIterations = app.MaxIterationsEditField.Value;


                    InputM = [(L1.^2) , L1 , 1; (L2.^2) , L2 , 1; (L3.^2) , L3 , 1];
                    InputRHS = [P1; P2; P3];
                    Guess = [1.4, 1.4, 1.4];

                    app.GaussSeidel2nd(InputM, InputRHS, Guess, maxIterations);

                elseif (app.order == "3rd")
                    L1 = app.Length1EditField.Value;
                    L2 = app.Length2EditField.Value;
                    L3 = app.Length3EditField.Value;
                    L4 = app.Length4EditField.Value;

                    P1 = app.Period1EditField.Value;
                    P2 = app.Period2EditField.Value;
                    P3 = app.Period3EditField.Value;
                    P4 = app.Period4EditField.Value;
                    maxIterations = app.MaxIterationsEditField.Value;

                    InputM = [(L1.^3), (L1.^2) , L1 , 1; (L2.^3), (L2.^2) , L2 , 1; (L3.^3), (L3.^2) , L3 , 1; (L4.^3), (L4.^2), L4, 1];
                    InputRHS = [P1; P2; P3; P4];
                    Guess = [1.4, 1.4, 1.4, 1.4];

                    app.GaussSeidel3rd(InputM, InputRHS, Guess, maxIterations);

                end
            end

        end

        % Value changed function: LPforGravConstantDropDown
        function LPforGravConstantDropDownValueChanged(app, event)
                                                                             % Credit: Alfarook Saleh

            
            value = app.LPforGravConstantDropDown.Value;                         
            
            if (value == "L1 / P1")                                          % This if statement takes the length and period selected by the user, processes it to find the gravitational
                L = app.Length1EditField.Value;                              % constant of the data, its percent error compared to the ideal gravitational constant, finds the ideal period for the selected length,
                P = app.Period1EditField.Value;                              % and displays those 3 values in their corresponding field box.
                app.GravitationalConstantestEditField.Value = ((L * pi*pi * 4) / (P*P))/100;
                g = app.GravitationalConstantestEditField.Value;
                app.GravConstPercentErrorEditField.Value = (abs(9.81 - g)/9.81) * 100;
                app.IdealPeriodsecondsEditField.Value = (2*pi*sqrt((L/100)/9.81));
                
            elseif (value == "L2 / P2")
                L = app.Length2EditField.Value;
                P = app.Period2EditField.Value;
                app.GravitationalConstantestEditField.Value = ((L * pi*pi * 4) / (P*P))/100;              
                g = app.GravitationalConstantestEditField.Value;
                app.GravConstPercentErrorEditField.Value = (abs(9.81 - g)/9.81) * 100;
                app.IdealPeriodsecondsEditField.Value = (2*pi*sqrt((L/100)/9.81));
                
            elseif (value == "L3 / P3")
                L = app.Length3EditField.Value;
                P = app.Period3EditField.Value;
                app.GravitationalConstantestEditField.Value = ((L * pi*pi * 4) / (P*P))/100;                
                g = app.GravitationalConstantestEditField.Value;
                app.GravConstPercentErrorEditField.Value = (abs(9.81 - g)/9.81) * 100;
                app.IdealPeriodsecondsEditField.Value = (2*pi*sqrt((L/100)/9.81));
                
            elseif (value == "L4 / P4")
                L = app.Length4EditField.Value;
                P = app.Period4EditField.Value;
                app.GravitationalConstantestEditField.Value = ((L * pi*pi * 4) / (P*P))/100;                
                g = app.GravitationalConstantestEditField.Value;
                app.GravConstPercentErrorEditField.Value = (abs(9.81 - g)/9.81) * 100;
                app.IdealPeriodsecondsEditField.Value = (2*pi*sqrt((L/100)/9.81));
                
            end
            
        end

        % Button pushed function: QuickInitButton
        function QuickInitButtonPushed(app, event)
            try                                                                                 % Credit: Alfarook Saleh
                % Developer function to make the project faster to test.
                % Won't be used in final product

                app.Uno = arduino('COM5', 'Uno', 'Libraries', 'Ultrasonic'); % assigning the arduino to the 'Uno' array for easy access

            catch
                msgbox('Arduino failed');
            end

            try
                app.ultraS = app.Uno.ultrasonic("D4", "D3");       % assigning the ultrasonic sensor to 'ultraS'

                msgbox ('Ardiono and Ultrasound ready');
            catch
                msgbox('Arduino Ready BUT Ultrasound failed');
                return;

            end

            writeDigitalPin(app.Uno, 'D7', 1);
            writeDigitalPin(app.Uno, 'D6', 1);



        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create ECE3040Project2UIFigure and hide until all components are created
            app.ECE3040Project2UIFigure = uifigure('Visible', 'off');
            app.ECE3040Project2UIFigure.Position = [100 100 1158 736];
            app.ECE3040Project2UIFigure.Name = 'ECE 3040 Project 2';

            % Create LoadMenu
            app.LoadMenu = uimenu(app.ECE3040Project2UIFigure);
            app.LoadMenu.Text = 'Load';

            % Create SwingDataMenu
            app.SwingDataMenu = uimenu(app.LoadMenu);
            app.SwingDataMenu.Text = 'Swing Data';

            % Create SwingData16inMenu
            app.SwingData16inMenu = uimenu(app.SwingDataMenu);
            app.SwingData16inMenu.MenuSelectedFcn = createCallbackFcn(app, @Data1MenuSelected, true);
            app.SwingData16inMenu.Text = 'Swing Data 1 (6in.)';

            % Create SwingData212inMenu
            app.SwingData212inMenu = uimenu(app.SwingDataMenu);
            app.SwingData212inMenu.MenuSelectedFcn = createCallbackFcn(app, @Data2MenuSelected, true);
            app.SwingData212inMenu.Text = 'Swing Data 2 (12in.)';

            % Create SwingData318inMenu
            app.SwingData318inMenu = uimenu(app.SwingDataMenu);
            app.SwingData318inMenu.MenuSelectedFcn = createCallbackFcn(app, @Data3MenuSelected, true);
            app.SwingData318inMenu.Text = 'Swing Data 3 (18in.)';

            % Create SwingData424inMenu
            app.SwingData424inMenu = uimenu(app.SwingDataMenu);
            app.SwingData424inMenu.MenuSelectedFcn = createCallbackFcn(app, @SwingData424inMenuSelected, true);
            app.SwingData424inMenu.Text = 'Swing Data 4 (24in.)';

            % Create CoefficientsMenu
            app.CoefficientsMenu = uimenu(app.LoadMenu);
            app.CoefficientsMenu.Text = 'Co-efficients';

            % Create stOrderMenu
            app.stOrderMenu = uimenu(app.CoefficientsMenu);
            app.stOrderMenu.MenuSelectedFcn = createCallbackFcn(app, @stOrderMenuSelected, true);
            app.stOrderMenu.Text = '1st Order';

            % Create ndOrderMenu
            app.ndOrderMenu = uimenu(app.CoefficientsMenu);
            app.ndOrderMenu.MenuSelectedFcn = createCallbackFcn(app, @ndOrderMenuSelected, true);
            app.ndOrderMenu.Text = '2nd Order';

            % Create rdOrderMenu
            app.rdOrderMenu = uimenu(app.CoefficientsMenu);
            app.rdOrderMenu.MenuSelectedFcn = createCallbackFcn(app, @rdOrderMenuSelected, true);
            app.rdOrderMenu.Text = '3rd Order';

            % Create UIAxes
            app.UIAxes = uiaxes(app.ECE3040Project2UIFigure);
            title(app.UIAxes, 'Pendulum Distance')
            xlabel(app.UIAxes, 'Time (seconds)')
            ylabel(app.UIAxes, 'Distance (meters)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [18 496 637 228];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.ECE3040Project2UIFigure);
            title(app.UIAxes2, 'Zeros of the Derivative of Input Data')
            xlabel(app.UIAxes2, '# of data points')
            ylabel(app.UIAxes2, 'd/dy')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [22 275 635 207];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.ECE3040Project2UIFigure);
            title(app.UIAxes3, 'Model of Pendulum Swing')
            xlabel(app.UIAxes3, 'Length (cm)')
            ylabel(app.UIAxes3, 'Period (seconds)')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [661 372 491 341];

            % Create GoodDataLampLabel
            app.GoodDataLampLabel = uilabel(app.ECE3040Project2UIFigure);
            app.GoodDataLampLabel.HorizontalAlignment = 'right';
            app.GoodDataLampLabel.Position = [544 106 64 22];
            app.GoodDataLampLabel.Text = 'Good Data';

            % Create GoodDataLamp
            app.GoodDataLamp = uilamp(app.ECE3040Project2UIFigure);
            app.GoodDataLamp.Position = [623 106 20 20];

            % Create ResetGraphButton
            app.ResetGraphButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.ResetGraphButton.ButtonPushedFcn = createCallbackFcn(app, @ResetGraphButtonPushed, true);
            app.ResetGraphButton.Position = [241 54 100 22];
            app.ResetGraphButton.Text = 'Reset Graph';

            % Create Measure7secondsButton
            app.Measure7secondsButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.Measure7secondsButton.ButtonPushedFcn = createCallbackFcn(app, @Measure7secondsButtonPushed, true);
            app.Measure7secondsButton.Position = [227 27 128 22];
            app.Measure7secondsButton.Text = 'Measure (7 seconds)';

            % Create PortEditFieldLabel
            app.PortEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.PortEditFieldLabel.HorizontalAlignment = 'right';
            app.PortEditFieldLabel.Position = [57 179 28 22];
            app.PortEditFieldLabel.Text = 'Port';

            % Create PortEditField
            app.PortEditField = uieditfield(app.ECE3040Project2UIFigure, 'text');
            app.PortEditField.Position = [100 179 100 22];

            % Create TriggerPinEditFieldLabel
            app.TriggerPinEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.TriggerPinEditFieldLabel.HorizontalAlignment = 'right';
            app.TriggerPinEditFieldLabel.Position = [21 143 64 22];
            app.TriggerPinEditFieldLabel.Text = 'Trigger Pin';

            % Create TriggerPinEditField
            app.TriggerPinEditField = uieditfield(app.ECE3040Project2UIFigure, 'text');
            app.TriggerPinEditField.Position = [100 143 100 22];

            % Create EchoPinEditFieldLabel
            app.EchoPinEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.EchoPinEditFieldLabel.HorizontalAlignment = 'right';
            app.EchoPinEditFieldLabel.Position = [31 109 54 22];
            app.EchoPinEditFieldLabel.Text = 'Echo Pin';

            % Create EchoPinEditField
            app.EchoPinEditField = uieditfield(app.ECE3040Project2UIFigure, 'text');
            app.EchoPinEditField.Position = [100 109 100 22];

            % Create BadDataLampLabel
            app.BadDataLampLabel = uilabel(app.ECE3040Project2UIFigure);
            app.BadDataLampLabel.HorizontalAlignment = 'right';
            app.BadDataLampLabel.Position = [551 80 56 22];
            app.BadDataLampLabel.Text = 'Bad Data';

            % Create BadDataLamp
            app.BadDataLamp = uilamp(app.ECE3040Project2UIFigure);
            app.BadDataLamp.Position = [622 80 20 20];
            app.BadDataLamp.Color = [1 0 0];

            % Create InitializeArduinoButton
            app.InitializeArduinoButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.InitializeArduinoButton.ButtonPushedFcn = createCallbackFcn(app, @StartUno, true);
            app.InitializeArduinoButton.Position = [83 74 103 22];
            app.InitializeArduinoButton.Text = {'Initialize Arduino'; ''};

            % Create RecordSwing1Button
            app.RecordSwing1Button = uibutton(app.ECE3040Project2UIFigure, 'state');
            app.RecordSwing1Button.ValueChangedFcn = createCallbackFcn(app, @RecordSwing1ButtonValueChanged, true);
            app.RecordSwing1Button.Text = 'Record Swing 1';
            app.RecordSwing1Button.Position = [241 179 100 22];

            % Create QuickInitButton
            app.QuickInitButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.QuickInitButton.ButtonPushedFcn = createCallbackFcn(app, @QuickInitButtonPushed, true);
            app.QuickInitButton.Position = [85 40 100 22];
            app.QuickInitButton.Text = 'Quick Init';

            % Create MeasuredRawDataLabel
            app.MeasuredRawDataLabel = uilabel(app.ECE3040Project2UIFigure);
            app.MeasuredRawDataLabel.Position = [364 167 129 22];
            app.MeasuredRawDataLabel.Text = 'Measured Raw Data = ';

            % Create MeasuredFilteredDataLabel
            app.MeasuredFilteredDataLabel = uilabel(app.ECE3040Project2UIFigure);
            app.MeasuredFilteredDataLabel.Position = [349 135 145 22];
            app.MeasuredFilteredDataLabel.Text = 'Measured Filtered Data = ';

            % Create LoadedRawDataLabel
            app.LoadedRawDataLabel = uilabel(app.ECE3040Project2UIFigure);
            app.LoadedRawDataLabel.Position = [378 106 115 22];
            app.LoadedRawDataLabel.Text = 'Loaded Raw Data = ';

            % Create LoadedFilteredDataLabel
            app.LoadedFilteredDataLabel = uilabel(app.ECE3040Project2UIFigure);
            app.LoadedFilteredDataLabel.Position = [362 75 131 22];
            app.LoadedFilteredDataLabel.Text = 'Loaded Filtered Data = ';

            % Create Label
            app.Label = uilabel(app.ECE3040Project2UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [451 168 25 22];
            app.Label.Text = '';

            % Create Lamp
            app.Lamp = uilamp(app.ECE3040Project2UIFigure);
            app.Lamp.Position = [491 168 20 20];
            app.Lamp.Color = [0 0 1];

            % Create Lamp_2Label
            app.Lamp_2Label = uilabel(app.ECE3040Project2UIFigure);
            app.Lamp_2Label.HorizontalAlignment = 'right';
            app.Lamp_2Label.Position = [451 136 25 22];
            app.Lamp_2Label.Text = '';

            % Create Lamp_2
            app.Lamp_2 = uilamp(app.ECE3040Project2UIFigure);
            app.Lamp_2.Position = [491 136 20 20];

            % Create Lamp_3Label
            app.Lamp_3Label = uilabel(app.ECE3040Project2UIFigure);
            app.Lamp_3Label.HorizontalAlignment = 'right';
            app.Lamp_3Label.Position = [451 106 25 22];
            app.Lamp_3Label.Text = '';

            % Create Lamp_3
            app.Lamp_3 = uilamp(app.ECE3040Project2UIFigure);
            app.Lamp_3.Position = [491 106 20 20];
            app.Lamp_3.Color = [1 0 1];

            % Create Lamp_4Label
            app.Lamp_4Label = uilabel(app.ECE3040Project2UIFigure);
            app.Lamp_4Label.HorizontalAlignment = 'right';
            app.Lamp_4Label.Position = [451 75 25 22];
            app.Lamp_4Label.Text = '';

            % Create Lamp_4
            app.Lamp_4 = uilamp(app.ECE3040Project2UIFigure);
            app.Lamp_4.Position = [491 75 20 20];
            app.Lamp_4.Color = [0 1 1];

            % Create RecordSwing3Button
            app.RecordSwing3Button = uibutton(app.ECE3040Project2UIFigure, 'state');
            app.RecordSwing3Button.ValueChangedFcn = createCallbackFcn(app, @RecordSwing3ButtonValueChanged, true);
            app.RecordSwing3Button.Text = 'Record Swing 3';
            app.RecordSwing3Button.Position = [241 114 100 22];

            % Create RecordSwing2Button
            app.RecordSwing2Button = uibutton(app.ECE3040Project2UIFigure, 'state');
            app.RecordSwing2Button.ValueChangedFcn = createCallbackFcn(app, @RecordSwing2ButtonValueChanged, true);
            app.RecordSwing2Button.Text = 'Record Swing 2';
            app.RecordSwing2Button.Position = [241 146 100 22];

            % Create MethodDropDownLabel
            app.MethodDropDownLabel = uilabel(app.ECE3040Project2UIFigure);
            app.MethodDropDownLabel.HorizontalAlignment = 'right';
            app.MethodDropDownLabel.Position = [694 189 46 22];
            app.MethodDropDownLabel.Text = 'Method';

            % Create MethodDropDown
            app.MethodDropDown = uidropdown(app.ECE3040Project2UIFigure);
            app.MethodDropDown.Items = {'Matrix Inverse', 'LU Decomposition', 'Gauss Seidel'};
            app.MethodDropDown.ValueChangedFcn = createCallbackFcn(app, @MethodDropDownValueChanged, true);
            app.MethodDropDown.Position = [755 189 208 22];
            app.MethodDropDown.Value = 'Matrix Inverse';

            % Create NthOrderModelDropDownLabel
            app.NthOrderModelDropDownLabel = uilabel(app.ECE3040Project2UIFigure);
            app.NthOrderModelDropDownLabel.HorizontalAlignment = 'right';
            app.NthOrderModelDropDownLabel.Position = [694 160 94 22];
            app.NthOrderModelDropDownLabel.Text = 'Nth Order Model';

            % Create NthOrderModelDropDown
            app.NthOrderModelDropDown = uidropdown(app.ECE3040Project2UIFigure);
            app.NthOrderModelDropDown.Items = {'1st', '2nd', '3rd'};
            app.NthOrderModelDropDown.ValueChangedFcn = createCallbackFcn(app, @NthOrderModelDropDownValueChanged, true);
            app.NthOrderModelDropDown.Position = [803 160 100 22];
            app.NthOrderModelDropDown.Value = '3rd';

            % Create AverageMeasuredPeriodEditFieldLabel
            app.AverageMeasuredPeriodEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.AverageMeasuredPeriodEditFieldLabel.HorizontalAlignment = 'right';
            app.AverageMeasuredPeriodEditFieldLabel.Position = [31 242 145 22];
            app.AverageMeasuredPeriodEditFieldLabel.Text = 'Average Measured Period';

            % Create AverageMeasuredPeriodEditField
            app.AverageMeasuredPeriodEditField = uieditfield(app.ECE3040Project2UIFigure, 'text');
            app.AverageMeasuredPeriodEditField.Enable = 'off';
            app.AverageMeasuredPeriodEditField.Position = [191 242 100 22];

            % Create AverageLoadedPeriodEditFieldLabel
            app.AverageLoadedPeriodEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.AverageLoadedPeriodEditFieldLabel.HorizontalAlignment = 'right';
            app.AverageLoadedPeriodEditFieldLabel.Position = [45 216 131 22];
            app.AverageLoadedPeriodEditFieldLabel.Text = 'Average Loaded Period';

            % Create AverageLoadedPeriodEditField
            app.AverageLoadedPeriodEditField = uieditfield(app.ECE3040Project2UIFigure, 'text');
            app.AverageLoadedPeriodEditField.Editable = 'off';
            app.AverageLoadedPeriodEditField.Position = [191 216 100 22];

            % Create CalculateModelButton
            app.CalculateModelButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.CalculateModelButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateModelButtonPushed, true);
            app.CalculateModelButton.Position = [745 126 102 22];
            app.CalculateModelButton.Text = 'Calculate Model';

            % Create Length1Label
            app.Length1Label = uilabel(app.ECE3040Project2UIFigure);
            app.Length1Label.HorizontalAlignment = 'right';
            app.Length1Label.Position = [745 334 52 22];
            app.Length1Label.Text = 'Length 1';

            % Create Length1EditField
            app.Length1EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Length1EditField.Position = [812 334 100 22];

            % Create Length2Label
            app.Length2Label = uilabel(app.ECE3040Project2UIFigure);
            app.Length2Label.HorizontalAlignment = 'right';
            app.Length2Label.Position = [745 301 52 22];
            app.Length2Label.Text = 'Length 2';

            % Create Length2EditField
            app.Length2EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Length2EditField.Position = [812 301 100 22];

            % Create Length3EditFieldLabel
            app.Length3EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Length3EditFieldLabel.HorizontalAlignment = 'right';
            app.Length3EditFieldLabel.Position = [745 272 52 22];
            app.Length3EditFieldLabel.Text = 'Length 3';

            % Create Length3EditField
            app.Length3EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Length3EditField.Position = [812 272 100 22];

            % Create Length4EditFieldLabel
            app.Length4EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Length4EditFieldLabel.HorizontalAlignment = 'right';
            app.Length4EditFieldLabel.Position = [745 242 52 22];
            app.Length4EditFieldLabel.Text = 'Length 4';

            % Create Length4EditField
            app.Length4EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Length4EditField.Position = [812 242 100 22];

            % Create Period4EditFieldLabel
            app.Period4EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Period4EditFieldLabel.HorizontalAlignment = 'right';
            app.Period4EditFieldLabel.Position = [933 242 50 22];
            app.Period4EditFieldLabel.Text = 'Period 4';

            % Create Period4EditField
            app.Period4EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Period4EditField.Position = [998 242 100 22];

            % Create Period3EditFieldLabel
            app.Period3EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Period3EditFieldLabel.HorizontalAlignment = 'right';
            app.Period3EditFieldLabel.Position = [933 272 50 22];
            app.Period3EditFieldLabel.Text = 'Period 3';

            % Create Period3EditField
            app.Period3EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Period3EditField.Position = [998 272 100 22];

            % Create Period2EditFieldLabel
            app.Period2EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Period2EditFieldLabel.HorizontalAlignment = 'right';
            app.Period2EditFieldLabel.Position = [933 301 50 22];
            app.Period2EditFieldLabel.Text = 'Period 2';

            % Create Period2EditField
            app.Period2EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Period2EditField.Position = [998 301 100 22];

            % Create Period1EditFieldLabel
            app.Period1EditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.Period1EditFieldLabel.HorizontalAlignment = 'right';
            app.Period1EditFieldLabel.Position = [933 334 50 22];
            app.Period1EditFieldLabel.Text = 'Period 1';

            % Create Period1EditField
            app.Period1EditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.Period1EditField.Position = [998 334 100 22];

            % Create cmLabel
            app.cmLabel = uilabel(app.ECE3040Project2UIFigure);
            app.cmLabel.Position = [756 218 29 22];
            app.cmLabel.Text = '(cm)';

            % Create secondsLabel
            app.secondsLabel = uilabel(app.ECE3040Project2UIFigure);
            app.secondsLabel.Position = [929 221 58 22];
            app.secondsLabel.Text = '(seconds)';

            % Create MaxIterationsEditFieldLabel
            app.MaxIterationsEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.MaxIterationsEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxIterationsEditFieldLabel.Visible = 'off';
            app.MaxIterationsEditFieldLabel.Position = [986 188 81 22];
            app.MaxIterationsEditFieldLabel.Text = 'Max Iterations';

            % Create MaxIterationsEditField
            app.MaxIterationsEditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.MaxIterationsEditField.Visible = 'off';
            app.MaxIterationsEditField.Position = [1083 188 55 22];

            % Create GravitationalConstantestEditFieldLabel
            app.GravitationalConstantestEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.GravitationalConstantestEditFieldLabel.HorizontalAlignment = 'right';
            app.GravitationalConstantestEditFieldLabel.Position = [671 69 155 22];
            app.GravitationalConstantestEditFieldLabel.Text = 'Gravitational Constant (est.)';

            % Create GravitationalConstantestEditField
            app.GravitationalConstantestEditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.GravitationalConstantestEditField.Editable = 'off';
            app.GravitationalConstantestEditField.Position = [831 69 75 22];

            % Create RecordCoeffecients1storderButton
            app.RecordCoeffecients1storderButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.RecordCoeffecients1storderButton.ButtonPushedFcn = createCallbackFcn(app, @RecordCoeffecients1storderButtonPushed, true);
            app.RecordCoeffecients1storderButton.Position = [935 140 183 22];
            app.RecordCoeffecients1storderButton.Text = 'Record Coeffecients (1st order)';

            % Create RecordCoeffecients2ndorderButton
            app.RecordCoeffecients2ndorderButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.RecordCoeffecients2ndorderButton.ButtonPushedFcn = createCallbackFcn(app, @RecordCoeffecients2ndorderButtonPushed, true);
            app.RecordCoeffecients2ndorderButton.Position = [933 109 187 22];
            app.RecordCoeffecients2ndorderButton.Text = 'Record Coeffecients (2nd order)';

            % Create RecordCoeffecients3rdorderButton
            app.RecordCoeffecients3rdorderButton = uibutton(app.ECE3040Project2UIFigure, 'push');
            app.RecordCoeffecients3rdorderButton.ButtonPushedFcn = createCallbackFcn(app, @RecordCoeffecients3rdorderButtonPushed, true);
            app.RecordCoeffecients3rdorderButton.Position = [934 77 184 22];
            app.RecordCoeffecients3rdorderButton.Text = 'Record Coeffecients (3rd order)';

            % Create LPforGravConstantDropDownLabel
            app.LPforGravConstantDropDownLabel = uilabel(app.ECE3040Project2UIFigure);
            app.LPforGravConstantDropDownLabel.HorizontalAlignment = 'right';
            app.LPforGravConstantDropDownLabel.Position = [694 98 124 22];
            app.LPforGravConstantDropDownLabel.Text = 'L/P for Grav. Constant';

            % Create LPforGravConstantDropDown
            app.LPforGravConstantDropDown = uidropdown(app.ECE3040Project2UIFigure);
            app.LPforGravConstantDropDown.Items = {'L1 / P1', 'L2 / P2', 'L3 / P3', 'L4 / P4'};
            app.LPforGravConstantDropDown.ValueChangedFcn = createCallbackFcn(app, @LPforGravConstantDropDownValueChanged, true);
            app.LPforGravConstantDropDown.Position = [831 98 75 22];
            app.LPforGravConstantDropDown.Value = 'L1 / P1';

            % Create RecordSwing4Button
            app.RecordSwing4Button = uibutton(app.ECE3040Project2UIFigure, 'state');
            app.RecordSwing4Button.ValueChangedFcn = createCallbackFcn(app, @RecordSwing4ButtonValueChanged, true);
            app.RecordSwing4Button.Text = 'Record Swing 4';
            app.RecordSwing4Button.Position = [241 85 100 22];

            % Create GravConstPercentErrorEditFieldLabel
            app.GravConstPercentErrorEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.GravConstPercentErrorEditFieldLabel.HorizontalAlignment = 'right';
            app.GravConstPercentErrorEditFieldLabel.Position = [671 38 147 22];
            app.GravConstPercentErrorEditFieldLabel.Text = 'Grav. Const. Percent Error';

            % Create GravConstPercentErrorEditField
            app.GravConstPercentErrorEditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.GravConstPercentErrorEditField.Editable = 'off';
            app.GravConstPercentErrorEditField.Position = [831 38 75 22];

            % Create IdealPeriodsecondsEditFieldLabel
            app.IdealPeriodsecondsEditFieldLabel = uilabel(app.ECE3040Project2UIFigure);
            app.IdealPeriodsecondsEditFieldLabel.HorizontalAlignment = 'right';
            app.IdealPeriodsecondsEditFieldLabel.Position = [692 6 126 22];
            app.IdealPeriodsecondsEditFieldLabel.Text = 'Ideal Period (seconds)';

            % Create IdealPeriodsecondsEditField
            app.IdealPeriodsecondsEditField = uieditfield(app.ECE3040Project2UIFigure, 'numeric');
            app.IdealPeriodsecondsEditField.Editable = 'off';
            app.IdealPeriodsecondsEditField.Position = [831 6 75 22];

            % Show the figure after all components are created
            app.ECE3040Project2UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Project_2_Complete

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.ECE3040Project2UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.ECE3040Project2UIFigure)
        end
    end
end