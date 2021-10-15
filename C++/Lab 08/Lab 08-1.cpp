//Alfarook Saleh gw5880
//Lab 08
#include <iostream>
#include <iomanip>

using namespace std;

int main()
{
	int A[25];
	srand(time(0));

	for (int i = 0; i < 25; i++)
	{
		A[i] = (rand() % 26);

		cout << A[i] << endl; //Not needed but just to double check the answer
		
	}

	int sumE = 0, sumO = 0; //sum for even and odd numbers

	for (int i = 0; i < 25; i++)
	{
		if (A[i] % 2 == 0)
		{
			sumE = sumE + A[i];
		}
		else
		{
			sumO = sumO + A[i];
		}

	}

	cout << "\nSum of even integers = " << sumE;
	cout << "\nSum of odd integers = " << sumO;
}