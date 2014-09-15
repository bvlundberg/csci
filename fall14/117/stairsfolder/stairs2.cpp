// Stair Problem

/*	Author: Brandon Lundberg
	File Name: stairs.cpp
	Purpose: To show basic C++ understanding iteratively
	Date: 21 August 2014
*/

#include <iostream>
	using namespace std;
int fib1(int n);

int main(){
	int n;
	int result = 0;
	cout << "Please enter the number of stairs: ";
	cin >> n;

	result = fib1(n);
	cout << "Number of ways to climb the stairs: " << result << endl;

	return 0;
}

int fib1(int n){
	if(n == 0)
		return 0;
	int a, b, c;
	a = 1;
	b = 0;
	c = 0;
	for(int i = 0; i < n; i++){
		c = b;
		b = a;
		a += c;
	}
	return a;
}