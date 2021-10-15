//Alfarook Saleh gw5880
//Lab 10
#include "dayType.h"

int main()
{
	dayType day;
	day.setDay("Tues");
	cout << day.getDay() << endl;
	cout << "Tomorrow is " << day.nextDay() << endl;
	day.print();

}