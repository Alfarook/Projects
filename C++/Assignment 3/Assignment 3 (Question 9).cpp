//Alfarook Saleh
//Assignment 3 Question 9
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cstdlib>
using namespace std;

int main()
{
    int guess, randomNumber;
  
    srand(time(0));

    randomNumber = (1 + rand() % 100);
    do
    {
        cout << "Choose a number between 1 and 100: " << endl;
        cin >> guess;

        if (guess < randomNumber)
            cout << "\nToo low, try again. \n" << endl;


        else if (guess > randomNumber)
            cout << "\nToo high, try again\n " << endl;
    }
   
    while (randomNumber != guess);
    
    {
        cout << guess << " was the correct numberf!" << endl;
    }
}