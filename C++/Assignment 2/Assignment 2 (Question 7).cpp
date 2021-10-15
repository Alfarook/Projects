//Alfarook Saleh gw5880
// Assignment 2 Question 7
#include <iostream>
#include <cmath>
#include <iomanip>
#include <math.h>
using namespace std;
int main()
{
	float x;
	char op;
	float y;

	cout << "Enter a number, then an operator followed by and another number" << endl << endl;
	cin >> x >> op >> y;

	switch (op)
	{
	case '+':
		cout << endl << x + y << endl;
		break;
	case '-':
		cout << endl << x - y << endl;
		break;
	case '*':
		cout << endl <<x * y << endl;
		break;
	case '/':
		if (y == 0)
			cout << endl << "Undefined" << endl;
		else if (y > 0 || y < 0)
			cout << endl << x / y << endl;
		break;
	case'^':
		cout << endl << pow(x, y) << endl;
		break;
	default:
		cout << endl << "No operator detected" << endl;
		break;
	}
}