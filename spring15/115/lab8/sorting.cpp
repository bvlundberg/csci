/*	Author:		Brandon Lundberg
	File Name: 	sorting.cpp
	Purpose: 	Implement sorting algorithms and display statistics for each one
	Date: 		19 April 2015
*/

#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <math.h>
using namespace std;

void swap(int *array, int x, int y){
	int temp = array[x];
	array[x] = array[y];
	array[y] = temp; 
}

void fyShuffle(int *array, int size){
	for (int i = size - 1; i > 0; i--){
		// Finding a random number that is 
		// within the boundry of 0 <= j <= i
		int j = rand() % i + 1;
		swap(array, i, j);
	}	
}

void copyArray(int *array1, int *array2, int size){
	for(int i = 0; i < size; i++){
		array2[i] = array1[i];
	}
}

void insertionSort(int *array, int size,int &swaps, int &comps){
	for(int i = 1; i < size; i++){
		comps++;
		for(int j = i; (j > 0) && (array[j] < array[j - 1]); j--){
			swap(array, j, j - 1);
			swaps++;
		}
	}
	return;
}

void bubbleSort(int *array, int size, int &swaps, int &comps){
	for(int i = 0; i < size; i++){
		for(int j = size - 1; j > i; j--){
			comps++;
			if(array[j] < array[j-1]){
				swap(array, j, j-1);
				swaps++;
			}
		}
	}
	return;
}

void selectionSort(int *array, int size, int &swaps, int &comps){
	for(int i = 0; i < size - 1; i++){
		int index = 0;
		for(int j = 1; j < size - 1; j++){
			comps++;
			if(array[j] > array[index]){
				index = j;
			}
			swap(array, index, size - i - 1);
			swaps++;
		}
	}
	return;
}

void mergeSort(int *array, int *temp, int left, int right, int &swaps, int &comps){
	if(left == right){
		return;
	}
	int mid = (left + right) / 2;
	mergeSort(array, temp, left, mid, swaps, comps);
	mergeSort(array, temp, (mid + 1), right, swaps, comps);
	for(int i = left; i <= right; i++){
		temp[i] = array[i];
	}
	int x = left;
	int y = mid + 1;
	for(int curr = left; curr <= right; curr++){
		comps++;
		if(x = mid + 1){
			array[curr] = temp[y++];
		}
		else if(y > right){
			array[curr] = temp[x++];
		}
		else if(temp[x] <= temp[y]){
			array[curr] = temp[x++];
		}
		else{
			array[curr] = temp[y++];
		}
	}
	return;
}

int findPivot(int i, int j){
	return (i+j)/2;
}

int partition(int *array, int left, int right, int pivot, int &swaps, int &comps){
	while(left <= right){
		comps++;
		while(array[left] < pivot){
			comps++;
			left++;
		}
		comps++;
		while((right >= left) && (array[right] >= pivot)){
			comps++;
			right--;
		}
		if(right > left){
			swap(array, left++, right--);
			swaps++;
		}
		return left;
	}
}

void quickSort(int *array, int i, int j, int &swaps, int &comps){
  int pivot = findPivot(i, j);
  swap(array, pivot, j); 
  swaps++;
  int k = partition(array, i, j-1, array[j], swaps, comps);
  swap(array, k, j);
  swaps++;                       
  if ((k-i) > 1) quickSort(array, i, k-1, swaps, comps);
  if ((j-k) > 1) quickSort(array, k+1, j, swaps, comps);
	return;
}

int main(){
	// Swaps and Comparisons
	int swaps[5][8] = {0};
	int comps[5][8] = {0};
	// Create Arrays
	int *array1 = new int[10];
	int *array2 = new int[100];
	int *array3 = new int[1000];
	int *array4 = new int[10000];
	int *array5 = new int[100000];
	int *array6 = new int[1000000];
	int *array7 = new int[10000];
	int *array8 = new int[10000];
	int *arrays[8] = {array1, array2, array3, array4, array5, array6, array7, array8};
	// Copies of the shuffled arrays for sorting
	int *tempArray1 = new int[10];
	int *tempArray2 = new int[100];
	int *tempArray3 = new int[1000];
	int *tempArray4 = new int[10000];
	int *tempArray5 = new int[100000];
	int *tempArray6 = new int[1000000];
	int *tempArray7 = new int[10000];
	int *tempArray8 = new int[10000];
	int *tempArrays[8] = {tempArray1, tempArray2, tempArray3, tempArray4, tempArray5, tempArray6, tempArray7, tempArray8};
	// Temp arrays for mergesort
	int *mergeArray1 = new int[10];
	int *mergeArray2 = new int[100];
	int *mergeArray3 = new int[1000];
	int *mergeArray4 = new int[10000];
	int *mergeArray5 = new int[100000];
	int *mergeArray6 = new int[1000000];
	int *mergeArray7 = new int[10000];
	int *mergeArray8 = new int[10000];
	int *mergeArrays[8] = {mergeArray1, mergeArray2, mergeArray3, mergeArray4, mergeArray5, mergeArray6, mergeArray7, mergeArray8};
	

	// Initialize values of main arrays
	for(int i = 0; i < 10; i++){
		array1[i] = i;
	}	
	for(int i = 0; i < 100; i++){
		array2[i] = i;
	}
	for(int i = 0; i < 1000; i++){
		array3[i] = i;
	}
	for(int i = 0; i < 10000; i++){
		array4[i] = i;
	}
	for(int i = 0; i < 100000; i++){
		array5[i] = i;
	}
	for(int i = 0; i < 1000000; i++){
		array6[i] = i;
	}
	for(int i = 0; i < 10000; i++){
		array7[i] = i;
	}
	int j = 9999;
	for(int i = 0; i < 10000; i++){
		array8[i] = j;
		j--;
	}
	// Shuffle first 6 arrays (last 2 do not need shuffling)
	srand(time(NULL));
	for(int i = 0; i < 6; i++){
		fyShuffle(arrays[i], pow(10,i+1));
	}
	// Variables to temporarily hold the swaps and comps for each sort
	int tempSwaps = 0, tempComps = 0;

	// Sort!
	int size = 0;
	for(int i = 0; i < 5; i++){
		for(int j = 0; j < 8; j++){
			tempSwaps = 0;
			tempComps = 0;
			if(j < 6){
				copyArray(arrays[j], tempArrays[j], pow(10, j+1));
				size = pow(10,j+1); 
			}
			else if(j == 7){
				copyArray(arrays[j], tempArrays[j], pow(10, 4));
				size = 10000;
			}
			else{
				size = 10000;
			}
			switch(i){
				case 0:
					insertionSort(tempArrays[j], size, tempSwaps, tempComps);
					break;
				case 1:
					bubbleSort(tempArrays[j], size, tempSwaps, tempComps);
					break;
				case 2:
					selectionSort(tempArrays[j], size, tempSwaps, tempComps);
					break;
				case 3:
					mergeSort(tempArrays[j], mergeArrays[j], 0, size, tempSwaps, tempComps);
					break;
				case 4:
					quickSort(tempArrays[j], 0, size, tempSwaps, tempComps);
					break;
				default:
					break;
			}
			swaps[i][j] = tempSwaps;
			comps[i][j] = tempComps;
		}
			
	}
	
	// Print Results
	
	cout << "Results\t\t10^1\t10^2\t10^3\t10^4\t10^5\t10^6\t10k\t10k" << endl;
	cout << "Insertion Sort\t";
	for(int i = 0; i < 8; i++){
		cout << "(" << swaps[0][i] << "," << comps[0][i] << ")" << "\t";
	}
	cout << endl;
	cout << "Bubble Sort\t";
	for(int i = 0; i < 8; i++){
		cout << "(" << swaps[1][i] << "," << comps[1][i] << ")" << "\t";
	}
	cout << endl;
	cout << "Selection Sort\t";
	for(int i = 0; i < 8; i++){
		cout << "(" << swaps[2][i] << "," << comps[2][i] << ")" << "\t";
	}
	cout << endl;
	cout << "Merge Sort\t";
	for(int i = 0; i < 8; i++){
		cout << "(" << swaps[3][i] << "," << comps[3][i] << ")" << "\t";
	}
	cout << endl;
	cout << "Quick Sort\t";
	for(int i = 0; i < 8; i++){
		cout << "(" << swaps[4][i] << "," << comps[4][i] << ")" << "\t";
	}
	cout << endl;
	
	return 0;
}