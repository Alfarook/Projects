#include <iostream>

using namespace std;

class dayType
{
private:
    string weekDay;
public:
    dayType();
    dayType(string d);
    void setDay(string d);
    string getDay();
    string nextDay();
    void print();
};