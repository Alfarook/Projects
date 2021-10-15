#include "dayType.h"

    dayType::dayType()
    {
        weekDay = "Sun";
    }
    dayType::dayType(string d)
    {
        weekDay = d;
    }
    void dayType::setDay(string d)
    {
        weekDay = d;
    }
    string dayType::getDay()
    {
        return weekDay;
    } 
    string dayType::nextDay()
    {
        string nextday;
        string days[7] = { "Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat" };
        for (int i = 0; i < 7; i++)
        {
            if (weekDay == days[i])
                nextday = days[(i + 1 % 7)];
        }
        return nextday;
    }
    void dayType::print()
    {
        cout << "The day is " << weekDay << endl;
    } 