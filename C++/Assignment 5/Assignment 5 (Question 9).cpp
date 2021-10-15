//Alfarook Saleh gw5880
//Assignment 5 (Question 9)
#include <iostream>
#include <iomanip>
using namespace std;

int FindWinner(int size, int votes[]) //Finds the index for the largest amount of votes A.K.A the winner.
{
	int largest = 0, index = 0;
	for (int i = 0; i < size; i++)
	{
		if (votes[i] > largest)
		{
			largest = votes[i];
			index = i;
		}
	}

	return index;
}

int main()
{
	const int size = 5;
	string names[size];
	int votes[size];
	double percentage[size];

	cout << "Enter the last names of the five candidates from the election.\n"; //Input Names
	for (int i = 0; i < size; i++)
	{
		cin >> names[i];
	}
	
	cout << "Enter the amount of votes each candidate received in chronological order.\n"; //Input amount of Votes
	for (int i = 0; i < size; i++)
	{
		cin >> votes[i];
	}

	double total = 0;					//Get Total Amount of Votes
	for (int i = 0; i < size; i++)
	{
		total = votes[i] + total;
	}
	
	for (int i = 0; i < size; i++)		//Get Percentages
	{
		percentage[i] = (votes[i] / total) * 100;
		cout << percentage[i] << "   " << votes[i] << "   " << total;
	}

	cout << "\nCandidate" << setw(20) << "Votes Received" << setw(25) << "% of Total Votes\n\n";	//Display Table
	for (int i = 0; i < size; i++)		
	{
		cout << setw(10) << names[i] << setw(15) << votes[i] << setw(20) << percentage[i] << endl;
	}
	cout << setw(10) << "Total" << setw(15) << total << endl << endl;

	cout << "The Winner of the Election is " << names[FindWinner(size, votes)] << '.';

}