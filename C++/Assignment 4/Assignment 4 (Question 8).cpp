//Alfarook Saleh gw5880
//Assignment 4 Question 8
#include<iostream>
#include<iomanip>

using namespace std;

double input()
{
	double num;

	cin >> num;

	return num;
}

double inflationRate(double currentPrice, double oldPrice)
{
	double rate;

	rate = (oldPrice - currentPrice) / oldPrice;

	return rate;
}

void Output(double value)
{
	cout << setprecision(4);
	cout << (value * 100) << "%" << endl;
}

int main()
{
	double currentPrice, oldPrice1, oldPrice2, rate1, rate2;

	cout << "Enter the current price: ";
	currentPrice = input();
	cout << "Enter last year's price: ";
	oldPrice1 = input();
	cout << "Enter the price from two years ago: ";
	oldPrice2 = input();

	cout << endl;

	rate1 = inflationRate(oldPrice1, currentPrice);
	rate2 = inflationRate(oldPrice2, oldPrice1);

	cout << "This year's inflation rate: "; Output(rate1);

	cout << "Last year's inflation rate: "; Output(rate2);

	cout << endl;

	if (rate1 < rate2)
	{
		cout << "The inflation rate is increasing" << endl;
	}
	else if (rate1 > rate2)
	{
		cout << "The inflation rate is decreasing" << endl;
	}
}

