/*	Author: Brandon Lundberg
	File Name: binarySearch.cpp
	Purpose: Time the binary search operation
	Date: 9 Feb 2015
*/
#include <cstdlib>      /* printf, NULL */
#include <iostream>
#include <time.h>       /* time */
using namespace std;

int binary(int A[], int n, int K) {
	int l = -1;
	int r = n; // l and r are beyond array bounds
	while (l+1 != r) { // Stop when l and r meet
		int i = (l+r)/2; // Check middle of remaining subarray
		if (K < A[i]) r = i; // In left half
		if (K == A[i]) return i; // Found it
		if (K > A[i]) l = i; // In right half
	}
	return n; // Search value not in A
}

int main(){
	time_t t1, t2;
	int n;
	cin >> n;
	int array[n];
	for(int i = 0; i < n; i++){
		array[i] = i;
	}

	int numSearches = 100000000;
	time(&t1);
	srand(time(NULL));
	for(int i = 0; i < numSearches; i++){
		int targetFound = binary(array, n, rand() % n);	// if value is found, targetFound will be the targetValue
	}
	time(&t2);
	cout << endl;
	cout << "It took " << difftime(t2, t1) << " seconds." << endl;
	return 0;
}