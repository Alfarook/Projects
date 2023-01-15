classdef add_class
    %This is a simple class where I show you how to do 
    %Object Oriented Programmingin Matlab.
    %Usage:
    %a = add_class (5,5);
    %a
    %a = a.X(10);  % try it withoug the a = and see what happens
    %a
    %a.add()
    %a.view()
    
    properties
        x;  % This is where the x value will be stored. 
        y;  % This is where the y value will be stored. 
        z;  % This is where the z value will be stored. 
    end
    methods % All the functions that act on the data.
        %Constructor class called when you setup the class
        function obj = add_class(x,y,z)  
            obj.x = x;
            obj.y = y;
            obj.z = z;  % adding another variable to be utilized in this class
            
        end
        %The sum function.
        function sum = add (obj)
            sum = obj.x + obj.y + obj.z;    % The extra z variable perform fine in this function, however it doesn't make much sense in the next functions
        end                                 % unless the user is allowed to choose which variables to perform on. 

                %The subtract function.
                function answer = subtract (obj)
            answer = obj.x - obj.y - obj.z;
                end

                %The multiply function.
        function answer = multiply (obj)
            answer = obj.x * obj.y * obj.z;
        end
                
        %The divide function.
        function answer = divide (obj)
            answer = obj.x / obj.y / obj.z;
        end
        %The view function
        function view (obj)
            s = sprintf ('x = %.2f y = %.2f z = %.2f', obj.x, obj.y, obj.z);
            disp (s)
        end
        %Function to change up the x value
        function obj = X (obj, x)
            obj.x = x;
        end
        %function to change the the y value
        function obj = Y (obj, y)
            obj.y = y;
        end
        %function to change the the z value
        function obj = Z (obj, z)
            obj.z = z;
        end
    end
end
