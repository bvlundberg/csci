/*	Author: Brandon Lundberg
	File Name: permutation.cpp
	Purpose:  Print all permutations of the first n positive integers
	Date: 3 Feb 2015
*/

#include <cstdlib>
#include <iostream>
using namespace std;

void swap(int array[], int i, int j){
	int temp = array[i];
	array[i] = array[j];
	array[j] = temp;
}

void printArray(int array[], int arraySize){
	for(int i = 0; i < arraySize; i++){
		cout << array[i] << " ";
	}
	cout << endl;
}

void permutate(int array[], int currentHead, int arraySize){
	if(currentHead == arraySize){
		printArray(array, arraySize);
		return;
	}
	else{
		for(int i = currentHead; i < arraySize; i++){
			swap(array, currentHead, i);
			permutate(array, currentHead + 1, arraySize);
			swap(array, currentHead, i);
		}
	}
}

int main(){
	// Number of elements to derive permutation
	int n;
	cin >> n;

	int array[n];

	for(int i = 0; i < n ; i++){
		array[i] = i + 1;
	}

	permutate(array, 0, n);

	return 0;
}