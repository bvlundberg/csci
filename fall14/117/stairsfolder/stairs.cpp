// Stair Problem

/*	Author: Brandon Lundberg
	File Name: stairs.cpp
	Purpose: To show basic C++ understanding using recursion
	Date: 21 August 2014
*/

#include <iostream>
	using namespace std;
int stairsRecursive(int n);
int stairsIterative(int n);
int stairsPlatformRecursion(int n);
int stairsPlatformIterative(int n);
int stairs123(int n);

int main(){
	int n;
	int result = 0;
	cout << "Please enter the number of stairs: ";
	cin >> n;

	result = stairsRecursive(n);
	cout << "Number of ways to climb the stairs with recursion: " << result << endl;
	result = stairsIterative(n);
	cout << "Number of ways to climb the stairs with iteration: " << result << endl;
	result = stairsPlatformRecursion(n);
	cout << "Number of ways to climb the stairs with recursion and platform: " << result << endl;
	result = stairsPlatformIterative(n);
	cout << "Number of ways to climb the stairs iteratively with platform: " << result << endl;

	result = stairs123(n);
	cout << "Number of ways to climb the stairs with 1, 2 or 3 steps: " << result << endl;
	
	return 0;
}

int stairsRecursive(int n){
	if(n == 0)
		return 1;
	else if(n < 0)
		return 0;
	else
		return stairsRecursive(n-1) + stairsRecursive(n-2);
}

int stairsIterative(int n){
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

int stairsPlatformRecursion(int n){
	if(n <= 0)
		return 1;
	else
		return stairsPlatformRecursion(n-1) + stairsPlatformRecursion(n-2);
}
int stairsPlatformIterative(int n){
	if(n == 0)
		return 0;
	int a, b, c;
	a = 1;
	b = 0;
	c = 0;
	for(int i = 0; i < n+1; i++){
		c = b;
		b = a;
		a += c;
	}
	return a;
}
int stairs123(int n){
	if(n == 0)
		return 1;
	else if(n < 0)
		return 0;
	else
		return stairs123(n-1) + stairs123(n-2) + stairs123(n-3);
}
