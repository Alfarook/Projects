//Alfarook Saleh
//Project 2 Extra Credit
#include "Rational.h"

int main()
{
	rational r1(1, 3), r2(7, 8), r7(2, 4), r8 (4, 8);	//some intitialzed rationals to be used
	int num, deno;
	

	r1.getNumeratorDenominator(num, deno);	//retrieves numerator and denominator from rational 1
	r1.printFraction(num, deno);			//prints the retrieved rational
	cout << " + ";
	r2.getNumeratorDenominator(num, deno);	//again, retrieves the numerator and denominator of the second rational
	r2.printFraction(num, deno);			//prints the newly retrieved rational
	cout << " = ";
	rational r3 = r1.add(r2);				//creates a new rational based on the first and second rational
	r3.getNumeratorDenominator(num, deno);	//retrieves the numerator and denominator of the third rational
	r3.printFraction(num, deno);			//prints the newly retrieved rational
	cout << endl;
	r3.printDecimal(num, deno);				//prints the rational in decimal form
	cout << endl;


	r1.getNumeratorDenominator(num, deno);		//rinse and repeat alot of times except using a different member function and a new rational identifier
	r1.printFraction(num, deno);
	cout << " - ";
	r2.getNumeratorDenominator(num, deno);
	r2.printFraction(num, deno);
	cout << " = ";
	rational r4 = r1.subtract(r2);
	r4.getNumeratorDenominator(num, deno);
	r4.printFraction(num, deno);
	cout << endl;
	r4.printDecimal(num, deno);
	cout << endl;


	r1.getNumeratorDenominator(num, deno);
	r1.printFraction(num, deno);
	cout << " * ";
	r2.getNumeratorDenominator(num, deno);
	r2.printFraction(num, deno);
	cout << " = ";
	rational r5 = r1.multiply(r2);
	r5.getNumeratorDenominator(num, deno);
	r5.printFraction(num, deno);
	cout << endl;
	r5.printDecimal(num, deno);
	cout << endl;


	r1.getNumeratorDenominator(num, deno);
	cout << '(';
	r1.printFraction(num, deno);
	cout << ") / (";
	r2.getNumeratorDenominator(num, deno);
	r2.printFraction(num, deno);
	cout << ") = ";
	rational r6 = r1.divide(r2);
	r6.getNumeratorDenominator(num, deno);
	r6.printFraction(num, deno);
	cout << endl;
	r6.printDecimal(num, deno);
	cout << endl;


	cout << endl << endl;		//separates the two different fraction combinations


	r7.getNumeratorDenominator(num, deno);			//very similar to the above code except a few extra lines, using r7 and r8 to change up the values
	r7.printFraction(num, deno);
	cout << " + ";
	r8.getNumeratorDenominator(num, deno);
	r8.printFraction(num, deno);
	cout << " = ";
	rational r9 = r7.add(r8);
	r9.getNumeratorDenominator(num, deno);			
	r9.printFraction(num, deno);
	cout << " ----------simplified: ";				//added this line to make it more clear
	r9 = r9.gcd(r9);								//here, a new function is used. gcd() simplifies the rational if it can be simplified. Otherwise, nothing happens. This was the tricky part! 
	r9.getNumeratorDenominator(num, deno);			//retrieving numerator and denominator again to show the simplified rational
	r9.printFraction(num, deno);					//printing to show the simplified rational
	cout << endl;	
	r9.printDecimal(num, deno);
	cout << endl;
													//rinse and repeat

	r7.getNumeratorDenominator(num, deno);
	r7.printFraction(num, deno);
	cout << " - ";
	r8.getNumeratorDenominator(num, deno);
	r8.printFraction(num, deno);
	cout << " = ";
	rational r10 = r7.subtract(r8);
	r10.getNumeratorDenominator(num, deno);
	r10.printFraction(num, deno);
	cout << " ----------simplified: ";
	r10 = r10.gcd(r10);
	r10.getNumeratorDenominator(num, deno);
	r10.printFraction(num, deno);
	cout << endl;
	r10.printDecimal(num, deno);
	cout << endl;


	r7.getNumeratorDenominator(num, deno);
	r7.printFraction(num, deno);
	cout << " * ";
	r8.getNumeratorDenominator(num, deno);
	r8.printFraction(num, deno);
	cout << " = ";
	rational r11 = r7.multiply(r8);
	r11.getNumeratorDenominator(num, deno);
	r11.printFraction(num, deno);
	cout << " ----------simplified: ";
	r11 = r11.gcd(r11);
	r11.getNumeratorDenominator(num, deno);
	r11.printFraction(num, deno);
	cout << endl;
	r11.printDecimal(num, deno);
	cout << endl;


	r7.getNumeratorDenominator(num, deno);
	cout << '(';
	r7.printFraction(num, deno);
	cout << ") / (";
	r8.getNumeratorDenominator(num, deno);
	r8.printFraction(num, deno);
	cout << ") = ";
	rational r12 = r7.divide(r8);
	r12.getNumeratorDenominator(num, deno);
	r12.printFraction(num, deno);
	cout << " ----------simplified: ";
	r12 = r12.gcd(r12);
	r12.getNumeratorDenominator(num, deno);
	r12.printFraction(num, deno);
	cout << endl;
	r12.printDecimal(num, deno);
	cout << endl;
}

