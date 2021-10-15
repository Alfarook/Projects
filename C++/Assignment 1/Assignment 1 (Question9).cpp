//Assignment 1, Question 9
//Alfarook Saleh gw5880
#include <iostream>
using namespace std;
int main()
{
	const double k = 0.0000000667;
	double mass1;
	double mass2;
	double distance;
	double force;

	cout << "Please enter the masses of the bodies" << endl;
	cin >> mass1 >> mass2;
	cout <<"Please enter the distance between the bodies" << endl;
	cin >> distance;
	cout << "The force between the two bodies is " << ((mass1 * mass2) / (distance * distance)) * k << 'J' << endl;
	return 0;
}