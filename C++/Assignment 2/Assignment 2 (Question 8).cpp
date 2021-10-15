//Alfarook Saleh gw5880
//Assignment 2 Question 8
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;
int main()
{
	float x1, x2, y1, y2;

	cout << "Enter the two x,y coordinates of a line as follows :" << endl << "Point x1 - ";
	cin >> x1;
	cout << endl << "Point y1 - ";
	cin >> y1;
	cout << endl << "Point x2 - ";
	cin >> x2;
	cout << endl << "Point y2 - ";
	cin >> y2;

	if (x2 > x1 || y2 > y1)
		cout << endl << "The line is increasing" << endl;
	else if (x2 < x1 || y2 < y1)
		cout << endl << "The line is decreasing" << endl;
	if (x2 == x1 && y2 == y1)
		cout << endl << "You have inputted the same point twice. No line can be made" << endl;
	else if (x2 == x1)
		cout << "The line is perfectly verticle, x = " << x1 << endl;
	else if (y2 == y1)
		cout << endl << "This line is perfectly horizontal, y = " << y1 << endl;
	else {
		float m /*slope*/ = (y2 - y1) / (x2 - x1);
		float b /*Y-intercept*/ = (m - x1);
		cout << endl << "y =" << m << "x +" << b << endl;
	}
 
}