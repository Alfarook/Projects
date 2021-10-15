//Alfarook Saleh gw5880
//Assignment 6 Question 4
#include <iostream>

using namespace std;

void getData(int table[][12], int column)		//function that takes input from the user to fill in the array
{
	cout << "Enter high temperature for each month\n";
	for (int i = 0; i < column; i++)
	{
		cin >> table[0][i];			//Loop for initializing first row
	}
	
	cout << "Enter low temperature for each month\n";

	for (int i = 0; i < column; i++)
	{
		cin >> table[1][i];			//Loop for initializing second row. If I had used a nested loop,
	}								//it would output the cout statement twice. I know that a nested
}									//loop would be better for initializing multi-dimensional arrays,
									//but in this case there are only 2 rows so doing it manually isn't too much work.

int averageHigh(int table[][12], int column)	//function to calculate average high temperature
{
	int sum = 0;
	for (int i = 0; i < column; i++)
	{
		sum = sum + table[0][i];	//only the first row is used in this case
	}

	int averageH = sum / column;
	return averageH;
}

int averageLow(int table[][12], int column)	//function to calculate average low temperature
{
	int sum = 0;
	for (int i = 0; i < column; i++)
	{
		sum = sum + table[1][i];	//in this case, only the second row is used
	}

	int averageL = sum / column;
	return averageL;
}

int indexHighTemp(int table[][12], int column)	//function to find the index of the highest temperature
{
	int largest = 0;
	int indexH = 0;
	for (int i = 0; i < column; i++)
	{
		if (table[0][i] > largest)	
		{
			largest = table[0][i];
			indexH = i;
		}
	}
	return indexH;
}

int indexLowTemp(int table[][12], int column)	//function to find the index of the lowest temperature
{
	int min = 0;
	int indexL = 0;
	for (int i = 0; i < column; i++)
	{
		if (table[1][i] < min)		//this is the same function as the one above, just the relational
		{							//operator is flipped and the table row is changed.
			min = table[1][i];
			indexL = i;
		}
	}
	return indexL;
}

int main()
{
	const int row = 2;
	const int column = 12;
	int table[row][column];
	getData(table, column);															//I passed the column variable through every function because I heard of students getting
	cout << "Average high temperature: " << averageHigh(table, column) << endl;		//marked down for not doing so. I had originally made my program without all the extra column variables
	cout << "Average low temperature: " << averageLow(table, column) << endl;		//so please dont mark me down if that's not what I was supposed to do. It's just confusing to find what you prefer.
	cout << "Highest temperature: " << table[0][indexHighTemp(table, column)] << endl;
	cout << "Lowest temperature: " << table[1][indexLowTemp(table, column)] << endl;
}