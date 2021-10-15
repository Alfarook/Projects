//Alfarook Saleh
//Project 1 Question 1
#include <iostream>     //Including files from library
#include <iomanip>
#include <string>
using namespace std;

void generalInfo() //Function to output general information
{
    cout << "Welcome to Stay Healthy and Fit center." << endl;
    cout << "This program determines the cost of a new membership." << endl;
    cout << "If you are a senior citizen, then the discount is 30% off of the regular membership price." << endl;
    cout << "If you buy membership for twelve month and pay today, the discount is 15%." << endl;
    cout << "If you buy and pay for 6 or more personal training sessions today, the discount on each session is 20%." << endl;
}


void Input(double& costPM, double& costPT, bool& seniorC, int& numberS, int& numberM) //Function to receive and allocate memory for various inputs
{
    char ch;
    cout << "Enter the cost of a regular membership per month: ";
    cin >> costPM;
    cout << "\nEnter the cost of one personal training session: ";
    cin >> costPT;
    cout << "\nAre you a senior citizen (Y,y/N,n): ";
    cin >> ch;
    
    if (ch == 'Y' || ch == 'y')
        seniorC = true;
    else if (ch == 'N' || ch == 'n')
        seniorC = false;

    cout << "\nEnter the number of personal training sessions bought: ";
    cin >> numberS;
    cout << "\nEnter the number of months you are paying for: ";
    cin >> numberM;
}


double calculateCost(double costPM, double costPT, bool seniorC, int numberS, int numberM) //Function to calculate membership cost with recieved input
{
    double costMS = costPM * numberM;

    if (seniorC)
    {
        costMS = costMS - (costPM * 0.30 * numberM);
    }

    if (numberM > 11)
    {
        costMS = costMS - (costMS * 0.15 );     //Tricky part here. Using the code "(costPM * 0.15 * numberM)" would discount from the total original price and not from the already discounted total price.
    }

    costMS = costMS + (costPT * numberS);

    if (numberS > 5)
    {
        costMS = costMS - (costPT * 0.20 * numberS);
    }

    return costMS;
}

int main()
{
    double costPM;      //Declaring variables
    double costPT;
    bool seniorCitizen;
    int numOfSessions;
    int numOfMonths;
    double costMS;
                            //Using the actual functions
        generalInfo();

        Input(costPM, costPT, seniorCitizen, numOfSessions, numOfMonths);

        costMS = calculateCost(costPM, costPT, seniorCitizen, numOfSessions, numOfMonths);

        cout << "\nThe membership cost = $" << setprecision(2) << fixed << costMS << endl;
}
