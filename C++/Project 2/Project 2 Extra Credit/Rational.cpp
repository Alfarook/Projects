//Alfarook Saleh
//Project 2 Extra Credit
#include "Rational.h"

rational::rational()
{
	numerator = 1;
	denominator = 1;
}
rational::rational(int num, int deno)
{
	numerator = num;
	denominator = deno;
}

void rational::setNumeratorDenominator(int num, int deno)
{
	numerator = num;
	denominator = deno;
}
void rational::getNumeratorDenominator(int& num, int& deno)
{
	num = numerator;
	deno = denominator;
}
rational rational::gcd(rational r3)
{
	int num = r3.numerator;
	int deno = r3.denominator;
	int gcd = 0;
	int smallest;
	
	if (num > deno)
		smallest = deno;
	else
		smallest = num;


	int d = 2;
	while (d <= smallest)
	{
		if (num % d == 0 && deno % d == 0)
		{
			gcd = d;
		}
		d++;
	}
	if (gcd != 0)
	{
		num = num / gcd;
		deno = deno / gcd;
	}

	rational newRational(num, deno);
	return newRational;
}
rational rational::add(rational r2)
{
	int num = (numerator * r2.denominator) + (r2.numerator * denominator);
	int deno = denominator * r2.denominator;
	rational newRational(num, deno);
	return newRational;
}
rational rational::subtract(rational r2)
{
	int num = (numerator * r2.denominator) - (r2.numerator * denominator);
	int deno = denominator * r2.denominator;
	rational newRational(num, deno);
	return newRational;
}
rational rational::multiply(rational r2)
{
	int num = numerator * r2.numerator;
	int deno = denominator * r2.denominator;
	rational newRational(num, deno);
	return newRational;
}
rational rational::divide(rational r2)
{
	int num = numerator * r2.denominator;
	int deno = denominator * r2.numerator;
	rational newRational(num, deno);
	return newRational;
}
void rational::printDecimal(int num, int deno)
{
	double decimal;

	decimal = static_cast<float>(num) / static_cast<float>(deno); //converted the integers into float for the decimal to show

	cout << "The decimal of " << num << '/' << deno << " is = " << fixed << setprecision(5) << decimal << endl;
}
void rational::printFraction(int num, int deno)
{
	cout << num << '/' << deno;
}
