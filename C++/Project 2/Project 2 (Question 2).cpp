//Alfarook Saleh gw5880
//Project 2 Question 2
#include <iostream>

using namespace std;


void readNumbers(int a[30], int b[30], int& lengthA, int &lengthB)
{
	char a1[30], b1[30], ra1[30], rb1[30];

	cout << "Enter a positive integer of at most 20 digits to be added:\n:";
	cin >> a1;

	if (strlen(a1) > 20)
	{
		cout << "You've entered a number greater than 20 digits. Program terminates!\n";
		exit(0);
	}
	
	lengthA = strlen(a1);		//saving string length of first array for future use

	for (int i = strlen(a1) + 1; i < 30; i++)
	{
		a1[i] = 0;
	}

	cout << "Enter another positive integer of at most 20 digits to be added.\n:";
	cin >> b1;

	if (strlen(b1) > 20)
	{
		cout << "You've entered a number greater than 20 digits. Program terminates!\n";
		exit(0);
	}
	
	lengthB = strlen(b1);		//saving string length of second array for future use

	for (int i = strlen(b1) + 1; i < 30; i++)
	{
		b1[i] = 0;
	}
	cout << b1 << endl;

	int i1 = 0;				//Reversing the first number
	for (int j = strlen(a1) - 1; j >= 0; j--)
	{
		ra1[i1] = a1[j];
		i1++;
	}
	ra1[i1] = '\0';
	cout << "This line reverses the first number: "<< ra1 <<endl;


	int i2 = 0;				//Reversing the second number
	for (int j = strlen(b1) - 1; j >= 0; j--)
	{
		rb1[i2] = b1[j];
		i2++;
	}
	rb1[i2] = '\0';
	cout << "This line reverses the second number: " << rb1 << endl;


	cout << "\nThis line ensures the first array of characters are converted into integers: ";
	for (int i = 0; i < strlen(a1); i++)	//converting first reversed number into integers
	{
		a[i] = ra1[i] - 48;
		cout << a[i];
	}

	cout << endl;

	cout << "\nThis line ensures the second array of characters are converted into integers: ";
	for (int i = 0; i < strlen(b1); i++)	//converting second reversed number into integers
	{
		b[i] = rb1[i] - 48;
		cout << b[i];
	}

	cout << endl;
}

void Sum(int a2[30], int b2[30], int sum[30], int lengthA, int lengthB)
{
	int carryOver = 0;
	int temp, shorter, longer;

	cout << "This line shows the number of digits in the first and second numbers respectively: "; // double checking if numbers transfer properly
	cout << lengthA << ' ' << lengthB << endl << endl;

	if (lengthA >= lengthB)		//determining which number is smaller or larger
	{
		shorter = lengthB;
		longer = lengthA;
	}
	else
	{
		shorter = lengthA;
		longer = lengthB;
	}


	for (int i = 0; i < shorter; i++)		//This loop is to add the numbers in the arrays
	{
		temp = a2[i] + b2[i] + carryOver;

		sum[i] = temp % 10;

		carryOver = (temp / 10);

	}

	for (int i = shorter; i < longer; i++)		//this loop is to continue adding the rest of the numbers of the larger array into the sum.
	{
		if (longer == lengthA)
			sum[i] = a2[i];
		else if (longer == lengthB)
			sum[i] = b2[i];
	}
	
	int index = 0;					//this loop reverses the numbers in sum to get the actual value
	int rsum[30];
	for (int j = longer - 1; j >= 0; j--)
	{
		rsum[index] = sum[j];
		index++;
	}


	cout << "The sum of the number is:\n";

	for (int i = 0; i < longer; i++) //longer is the problem! I can't find a way to find the length of rsum
	{
		if (i == 21)
		{
			cout << "\nThe sum of the numbers overflows. It has 21 digits. Program will not print the number.";
			exit(0);		//I tried terminating the program when the sum is over 20 digits long
		}					//but without the length of rsum, I couldn't stop the program because 
		cout << rsum[i];	//it never goes above 20 digits because of the 'longer' variable
	}
}


int main() 
{
	const int size = 30;
	int a[size], b[size], sum[size];
	int lengthA, lengthB;  //variables to keep track of string length of arrays

	readNumbers(a, b, lengthA, lengthB);

	Sum(a, b, sum, lengthA, lengthB);
	
}