//Alfarook Saleh gw5880
//Project 1 Question 2
#include<iostream>		//Including files from the library
#include<fstream>

using namespace std;

void mergeFile(string& infile1, string& infile2, string& outfile)		//Function that takes 3 file names. It opens the first two, reads, prints contents onto Command Prompt,
{																		//and saves contents of those two files onto the third file, then prints contents of the third file onto Command Prompt.

	ifstream Infile1(infile1), Infile2(infile2), outfile2(outfile);		//outfile2(outfile) should not be here, but since I was unable to sort the numbers, I added this to be able to print out the contents of the outfile.

	ofstream Outfile(outfile);

	int num = 0, num2 = 0;

	cout << "Contents of file " << infile1 << " are:" << endl;

	if (Infile1.is_open())		//Loop to read, print, and save contents of file 1 onto outfile

	{
		while (!Infile1.eof())

		{

			Infile1 >> num;

			cout << num << endl;

			Outfile << num << endl;

		}

	}

	cout << "Contents of file " << infile2 << " are:" << endl;

	if (Infile2.is_open())		//Loop to read, print, and save contents of file 2 onto outfile

	{
		while (!Infile2.eof())

		{

			Infile2 >> num;

			cout << num << endl;

			Outfile << num << endl;

		}

	}


	cout << "Contents of file " << outfile << " are:" << endl;

	/*if (Infile1.is_open() || Infile2.is_open())		//This is a mix of various attempts at trying to solve the sorting problem
	
	while (Infile1 >> num && Infile2 >> num2)

	{
		if (num <= num2)

		{
			Infile1 >> num;
			Outfile << num << endl;
			
			cout << num << endl;

		}

		else

		{
			Infile2 >> num2;
			Outfile << num2 << endl;
			
			cout << num2 << endl;

		}

	}

	if (num <= num2)

	{
		while (!Infile2.eof())

		{

			Infile2 >> num2;
			Outfile << num2 << endl;
			
			cout << num2 << endl;

		}

	}

	else

	{
		while (!Infile1.eof())
		
		{
			Infile1 >> num;
			Outfile << num << endl;
				
			cout << num << endl;
		}
	}*/			
	
	
				
	
	
	
				
	
	
	
				//I spent many hours trying and searching how to figure out how to 
				//organize the numbers but to no avail.
				//A quick explanation on how to do this would be much appreciated.
				//Above are several attempts of me trying, None of which did anything but
				//I decided to leave them there as proof of effort.
	

	if (outfile2.is_open())		//Loop to read and print outfile

	{
		while (!outfile2.eof())

		{

			outfile2 >> num;

			cout << num << endl;

		}

	}

	Infile1.close();
	Infile2.close();
	Outfile.close();

}

int main()

{
	string file1, file2, outputfile;		//Declaring variables

	cout << "Enter the first of two input file names:\n";	//Taking inputs
	cin >> file1;
	cout << "Now a second input file name:\n";
	cin >> file2;
	cout << "Enter the output file name. ";
	cout << endl << "WARNING: ANY EXISTING FILE WITH THIS NAME WILL BE ERASED.\n";
	cin >> outputfile;

	mergeFile(file1, file2, outputfile);		//Implementing the inputs into the function

}
