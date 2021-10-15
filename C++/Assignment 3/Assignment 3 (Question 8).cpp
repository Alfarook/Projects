//Alfarook Saleh
//Assignment 3 Question 8
#include <iostream>
#include <cmath>
#include <string>
#include <iomanip>
#include <fstream>

using namespace std;
int main()
{
	ifstream inFile;
	ofstream outFile;

	string firstname, lastname;
	double salary, payincrease, updatedsalary;

	inFile.open("Data.txt");
	outFile.open("Output.dat");

	while (inFile >> lastname >> firstname >> salary >> payincrease)
		outFile << firstname << ' ' << lastname << ' ' << (salary * payincrease / 100 + salary) << endl;

	inFile.close();
	outFile.close();
}
