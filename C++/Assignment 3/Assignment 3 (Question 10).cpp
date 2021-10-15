//Alfarook Saleh
//Assignment 3 Question 10
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cstdlib>
#include <fstream>
using namespace std;

int main()
{
    int count = 0;
    int num;
    int sum = 0;
    double avg = 0.0;
   ifstream inFile;

    inFile.open("Random.txt");
    while (inFile >> num)
    {
        count++;
        sum += num;
    }
  
    inFile.close();

    avg = (double) sum / count;

    cout << "Amount of numbers in Random.txt : " << count << endl;
    cout << "Sum of numbers in Random.txt : " << sum << endl;
    cout << "Average of all the numbers in Random.txt : " << avg << endl;

}