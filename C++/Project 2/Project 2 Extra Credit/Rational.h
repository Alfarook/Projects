//Alfarook Saleh
//Project 2 Extra Credit
#include <iostream>
#include <iomanip>
using namespace std;

class rational
{
private:
	int numerator;
	int denominator;
public:
	rational();
	rational(int num, int deno);
	void setNumeratorDenominator(int num, int deno);
	void getNumeratorDenominator(int& num, int& deno);
	rational gcd(rational r2);
	rational add(rational r2);
	rational subtract(rational r2);
	rational multiply(rational r2);
	rational divide(rational r2);
	void printDecimal(int num, int deno);
	void printFraction(int num, int deno);
};
