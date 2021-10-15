//Alfarook Saleh gw5880
//Lab 09
#include <iostream>

using namespace std;

int lastLargestIndex( int a[], int size)
{
	int largest = 0;
	int index = 0;
	for (int i = 0; i < size; i++)
	{
		if (largest <= a[i])
		{
			largest = a[i];
			index = i;
		}
	}
	return index;
}

int main()
{
	const int size = 15;
	int a[size] = { 56, 34, 67, 54, 23, 87, 66, 92, 15, 32, 55, 54, 88, 92, 30 };

	cout << "List of elements: ";
	for (int i = 0; i < size; i++)
	{
		cout << a[i] << ' ';
	}

	cout << "\nThe position of the last occurrence of the largest element in the list is: " << lastLargestIndex(a, size);
	cout << "\nThe largest element in the list is: " << a[lastLargestIndex(a, size)];
}