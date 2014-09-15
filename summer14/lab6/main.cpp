/* Lab 6 */

/* Author: Brandon Lundberg
   File Name: main.cpp
   Purpose: Merge and Quick Sort
   Date: 15 July 2014
*/

#include <iostream>
using namespace std;
void printArray(int array[]){
	for(int i = 0; i < 10; i++){
		cout << array[i] << " ";
	}
	cout<< endl;
}
void swaps(int array[], int low, int high){
	int temp = array[low];
	array[low] = array[high];
	array[high] = temp;
}
int partition(int array[], int low, int high){
	int pivot = low, i = low + 1, j = high;
	while(i < j){
		while(array[i] < array[pivot]){i++;}
		while(array[j] > array[pivot]){j--;}

		if(i >= j)break;
		swaps(array, i, j);
	}
	swaps(array, pivot, j);
	return j;
}
void quickSort(int array[], int low, int high){
	if(high <= low) return;
	int j = partition(array, low, high);
	quickSort(array, low, j-1);
	quickSort(array, j+1, high);
}
void merge(int array[], int low, int mid, int high){
	int i = low, j = mid+1;
	int aux[sizeof(array)];
	for(int k = 0; k < high; k++){
		aux[k] = array[k];
	}
	for(int k = 0; k < high; k++){
		if(i > mid){
			array[k] = aux[j];
			j++;
		}
		else if(j > high){
			array[k] = aux[i];
			i++;
		}
		else if(aux[j] < aux[i]){
			array[k] = aux[j];
			j++;
		}
		else{
			array[k] = aux[i];
			i++;
		}


	}
}
void mergeSort(int array[], int low, int high){
	printArray(array);
	if(low < high){
		int mid = (low+high)/2;
		mergeSort(array, low, mid);
		mergeSort(array, mid+1, high);
		merge(array, low, mid, high);
	}
}

int main(){
	int quickArray[] = {54, 26, 97, 3, 42, 97, 33, 13, 82, 73};
	int mergeArray[] = {54, 26, 97, 3, 42, 97, 33, 13, 82, 73};
	printArray(quickArray);
	printArray(mergeArray);
	cout << endl;
	// Sorts
	quickSort(quickArray, 0, 9);
	mergeSort(mergeArray, 0, 9);
	cout << endl;
	// Results
	printArray(quickArray);
	printArray(mergeArray);

	return 0;
}