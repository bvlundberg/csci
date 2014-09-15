#include <iostream>
#include <cmath>
using namespace std;
int x = 10;

//compute square of the input using call by pointer.
void func1(int* x) {
	*x = *x * *x;
}

//compute square of the input using call by reference
void func2(int &x)
{
	x = x * x;
}

void func3()
{
static int x=6;
cout<<"x ="<<x<<endl;
x+=3;
}

void func4()
{
x+=3;
cout<<"x ="<<x<<endl;
}

//compute square of the input using call by value.
void func5(int value)
{
	value = value * value;
}

int recursion(int y){
	if (y == 0)
		return 0;
	else
		return y + recursion(y-1);
}

double harmonic(double x){
	if(x == 0)
		return 0;

	return 1/x + harmonic(x-1);
}

int geometric(int x){
	if(x == 0)
		return 0;
	else
		return pow(2,x-1) + geometric(x-1);
}

int main()
{
	int x = 5;
	int y = 6;

	cout<<"x ="<<x<<endl;
	{
		int x = 8;
		cout<<"x ="<<x<<endl;
	}
	func1(&x); //fill in the input variable
	cout<<"x ="<<x<<endl;
	func2(x); //fill in the input variable
	cout<<"x ="<<x<<endl;
	func3(  );
	func4(  );
	func3(  );
	cout<<"x ="<<x<<endl;
	func5(x); //fill in the input variable
	cout<<"x ="<<x<<endl;
	cout << "recursion: " << recursion(y) << endl;
	cout << "harmonic: " << harmonic(y) << endl;
	cout << "Geometic: " << geometric(y) << endl;
	return 0;
}
