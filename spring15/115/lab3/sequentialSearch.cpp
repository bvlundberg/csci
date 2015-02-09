#include <cstdlib>      /* printf, NULL */
#include <iostream>
#include <time.h>       /* time */
using namespace std;

int sequential(int A[], int n, int K) {
	for(int i = 0; i < n; i++){
		if(A[i] == K)
			return K;
	}
	return n; // Search value not in A
}

int main(){
	int n;
	cin >> n;
	int array[n];
	for(int i = 0; i < n; i++){
		array[i] = i;
	}

	int numSearches = 10000;
	srand(time(NULL));
	for(int i = 0; i < numSearches; i++){
		int targetFound = sequential(array, n, rand() % n);	// if value is found, targetFound will be the targetValue
		cout << targetFound << " ";
	}
	
	cout << endl;
	return 0;
}