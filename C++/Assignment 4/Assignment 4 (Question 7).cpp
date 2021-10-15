//Alfarook Saleh gw5880
//Assignment 4 Question 7
#include <iostream>
#include <math.h>

using namespace std;

const double pi = 3.1416;


double distance(double x1, double x2, double y1, double y2)
{
	double distance;
	distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
	return distance;
}


double radius(double x1, double x2, double y1, double y2)
{

	double radius;
	radius = distance(x1, x2, y1, y2);
	return radius;
}

double circumference(double r)
{
	double circumference;
	circumference = 2 * pi * r;
	return circumference;
}

double area(double R)
{
	double area;
	area = pi * pow(R, 2);
	return area;
}

int main()
{
	double x1, x2, y1, y2;
	cout << "Enter the center of a circle first, then a point on the circle in this format: x1,y1,x2,y2\n";
	cin >> x1 >> y1 >> x2 >> y2;
	cout << "The radius of the circle is " << radius(x1, x2, y1, y2) << endl;
	cout << "The diameter of the circle is " << 2 * radius(x1, x2, y1, y2) << endl;
	cout << "The circumference of the circle is " << circumference(radius(x1, x2, y1, y2)) << endl;
	cout << "The area of the circle is " << area(radius(x1, x2, y1, y2)) << endl;

}

