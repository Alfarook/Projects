//Assignment 1, Question 8
//Alfarook Saleh gw5880
#include <iostream>
using namespace std;
int main()
{
	const double litersPerCarton = 3.78;
	const double costOfLiter = 0.38;
	const double profitOfCarton = 0.27;
	double liter;
	cout << "Please enter how many liters of milk were produced in the morning." << endl;
	cin >> liter;
	cout << "The amount of milk cartons produced is " << liter / litersPerCarton << endl;
	cout << "The cost of producing that milk is $" << liter * costOfLiter << endl;
	cout << "The profit gained from producing the milk is $" << (liter / litersPerCarton) * profitOfCarton << endl;
	return 0;
}