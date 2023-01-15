function AvgPeriod = getPeriod_test2(time,position)
%value = app.DropDown.Value;

time = [-2*pi:0.1:2*pi];
position = sin(time);

i = 1;
j = 1;
peak = 0;
tPeak = [];
pPeak = [];
count = 1;
oldSlope = 0;
period = [];

while (i < size(time, 2))
    yp1 = position(i);
    xp1 = time(i);
    
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
    
    
    if (sign ~= oSign)
        peak = peak + 1;
        tPeak(1, count) = time(i + 1);
        pPeak(1, count) = position(i + 1);
        count = count + 1;
    end
    
    oldSlope = slope;
    

    i = i + 1;
end

while (j < size(tPeak,2))
    period(1, j) = tPeak(j) -tPeak(j + 1);
    j = j + 1;
end

AvgPeriod = abs(sum(period)/size(period, 2));
end
