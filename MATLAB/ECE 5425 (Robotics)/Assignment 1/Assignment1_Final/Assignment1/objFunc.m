function e = objFunc(a)
totalError = 0;
data = [1 6.2; -1 2.1; 0 3.4; 2 10.9; 3 18.2];

for p = 1:5
    theta = data(p, 1);
    ymeasured = data(p, 2);
    ysimulated = a(1)*theta*theta+a(2)*theta + a(3)
    pointError = abs(ymeasured-ysimulated);
    totalError = totalError + pointError;
end 

e = totalError;

end