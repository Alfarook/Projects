//Alfarook Saleh gw5880
//Project 2 Question 1
#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int cards[4][4] = { {1,1,2,2},{3,3,4,4}, {5,5,6,6} ,{ 7,7,8,8} };		//global variables to be used in all functions
bool cover[4][4] = { {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0} };

void initializeTable()
{
	srand(time(0));							//This function randomizes the table every time
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			int temp = cards[i][j];
			int r = rand() % 4;
			int c = rand() % 4;
			cards[i][j] = cards[r][c];
			cards[r][c] = temp;
		}
	}

	cout << "ANSWER SHEET" << endl;		//this is to view the answer
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
			cout << cards[i][j] << " ";
		cout << endl;
	}

}

void printTable()
{

	/*cout << "print table - program view" << endl;			// testing printing table
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
			cout << cards[i][j] << " ";
		cout << endl;
	}
	*/

	for (int i = 0; i < 4; i++)					//This prints the table the player should see
	{
		for (int j = 0; j < 4; j++)
		{
			if (cover[i][j] == false)
				cout << "* ";
			else
				cout << cards[i][j] << ' ';
		}
		cout << endl;
	}
}

void printRules()
{
	cout << "Welcome to the card memory game!\n";
	cout << "The goal of this game is to uncover all of the hidden cards on the table.\n";
	cout << "To do so, please enter the row number and column number of the card you want to uncover.\n";
}

void startGame()
{
	printTable();
	int flippedCards = 0;
	while (flippedCards < 8)
	{
		int r1, r2, c1, c2;

		cout << "Enter the row (1 to 4) and column (1 to 4) position of the first card\n: ";

		cin >> r1 >> c1;


		if (cover[r1 - 1][c1 - 1] == true) 
		{
			do {			//this loop prevents the player from inputting a faced up card
				cout << "Card at this position is already faced up. Select again!\n";
				cin >> r1 >> c1;
			} while (cover[r1 - 1][c1 - 1] == true);
		}



		if (r1 < 1 | r1 > 4 | c1 < 1 | c1 > 4)
		{
			do {			//this loop prevents the player from inputting an invalid number
				if (r1 < 1 | r1 > 4)
					cout << "Invalid row position. Try again!\n";
				if (c1 < 1 | c1 > 4)
					cout << "Invalid column position. Try again!\n";

				cout << "Please input the correct row and column number on the table.\n:";
				cin >> r1 >> c1;
			} while (r1 < 1 | r1 > 4 | c1 < 1 | c1 > 4);
		}


		cover[r1 - 1][c1 - 1] = true;

		printTable();

		cout << "Enter the row (1 to 4) and column (1 to 4) position of the second card\n: ";

		cin >> r2 >> c2;


		if (cover[r2 - 1][c2 - 1] == true)
		{
			do {			//this loop prevents the player from inputting a faced up card
				cout << "Card at this position is already faced up. Select again!\n";
				cin >> r2 >> c2;
			} while (cover[r2 - 1][c2 - 1] == true);
		}


		if (r2 < 1 | r2 > 4 | c2 < 1 | c2 > 4)
		{
			do {			//this loop prevents the player from inputting an invalid number
				if (r2 < 1 | r2 > 4)
					cout << "Invalid row position. Try again!\n";
				if (c2 < 1 | c2 > 4)
					cout << "Invalid column position. Try again!\n";

				cout << "Please input the correct row and column number on the table.\n:";
				cin >> r2 >> c2;
			} while (r2 < 1 | r2 > 4 | c2 < 1 | c2 > 4);
		}


		cover[r2 - 1][c2 - 1] = true;

		printTable();

		if (cards[r1 - 1][c1 - 1] != cards[r2 - 1][c2 - 1])	//this loop determines if the cards match or not
		{
			cout << "Pair does not match. Select again!\n";
			cover[r1 - 1][c1 - 1] = false;
			cover[r2 - 1][c2 - 1] = false;
		}
		else
		{
			cout << "Pair match!\n";
			flippedCards++;
		}

	}

	cout << "Congratulations! You've won the game!\n";
}

int main()
{
	initializeTable();			//main function with only calls to functions
	printRules();
	startGame();
}
