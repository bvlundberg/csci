/* Lab 5 */

/* Author: Brandon Lundberg
   File Name: main.cpp
   Purpose: Selection and Insertion Sort
   Date: 10 July 2014
*/

#include <iostream>
#include <cstring>
using namespace std;
void printString(string name){
	cout << name << endl;
}
void swaps(string &name, int index, int newIndex){
	char temp;
	temp = name[index];
	name[index] = name[newIndex];
	name[newIndex] = temp;

}
void insertionSort(string &name){
	for(int i = 1; i < name.size(); i++){
		for(int j = i; j >= 0 && name[j] < name[j-1]; j--){
				swaps(name, j-1, j);
		}
		}
	}
void selectionSort(string &name){
	for(int i = 0; i < name.size(); i++){
		char min = name[i];
		int minSpot = i;
		int prevMinSpot = minSpot;
		for(int j = i+1; j < name.size(); j++){
			if(name[j] < min){
				min = name[j];
				minSpot = j;
			}
		}
		if(minSpot != prevMinSpot){
			swaps(name, i, minSpot);
		}
	}
}

void shellSort(string &name){
		int shift = name.size();
		for(shift; shift > 0; shift = shift /2){
			for(int i = shift; i < name.size(); i++){
				for(int j = i; j >= 0; j -= shift){
					if(name[j] < name[j-1])
						swaps(name, j-1, j);
				}
			}
		}
}

int main(){
	string selectionString = "SORTEXAMPLE";
	string insertionString = "SORTEXAMPLE";
	string shellString = "SORTEXAMPLE";
	// Print Original
	cout << "Originals" << endl;
	cout << "Selection:\t ";
	printString(selectionString);
	cout << "Insertion:\t ";
	printString(insertionString);
	cout << "Shell:\t\t ";
	printString(shellString);

	cout << "Results" << endl;
	// Run Sorts
	selectionSort(selectionString);
	insertionSort(insertionString);
	shellSort(shellString);
	// Print Post-sort
	cout << "Selection:\t";
	printString(selectionString);
	cout << "Insertion:\t";
	printString(insertionString);
	cout << "Shell:\t\t";
	printString(shellString);
	
	return 0;
}
