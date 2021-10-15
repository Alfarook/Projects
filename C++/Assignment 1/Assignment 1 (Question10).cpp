//Assignment 1, Question 10
//Alfarook Saleh gw5880
#include <iostream>
using namespace std;
int main()
{
	double lengthWire;

	cout << "Please enter the length of a wire" << endl;
	cin >> lengthWire;

	double widthFrame = lengthWire / 5;
	const double lengthFrame = 1.5 * widthFrame;

	cout << "The length and width of the picture frame is " << lengthFrame << " and " << widthFrame << " respectively." << endl;
	return 0;
}