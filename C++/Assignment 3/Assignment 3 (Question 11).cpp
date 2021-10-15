//Alfarook Saleh
//Assignment 3 Question 11
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cstdlib>
#include <fstream>
using namespace std;

int main()
{
    int x, y, count = 0;
    
    for (x = 1; x <= 7; x++)

        for (y = x + 1; y <= 7; y++) 
        {
            cout << x << ' ' << y << endl;
            count++;
        }
    cout << " The total number of all combinations is: " << count << endl;
  
}