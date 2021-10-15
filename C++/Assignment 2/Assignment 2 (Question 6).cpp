//Alfarook Saleh gw5880
//Assignment 2 Question 6
#include <iostream>
#include <iomanip>
#include <cmath>
#include <math.h>

using namespace std;
int main()
{
	float a;
	float b;
	float c;
	
	cout << "Enter the 'a' value :" << endl;
	cin >> a;
	cout << "Enter the 'b' value :" << endl;
	cin >> b;
	cout << "Enter the 'c' value :" << endl;
	cin >> c;

	float discriminant = (pow(b, 2)) - (4.0 * a * c);
	float root1 = (-b + sqrt(discriminant)) / (2.0 * a);
	float root2 = (-b - sqrt(discriminant)) / (2.0 * a);

	if (discriminant == 0)
		cout << "The equation has one real root : " << root1 << endl;

	else if (discriminant < 0)
		cout << "The equation has two complex roots" << endl;

	else if (discriminant > 0)
		cout << "The equation has two real roots : " << root1 << " and " << root2 << endl;
}