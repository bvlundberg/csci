/* Lab 7 */

/* Author: Brandon Lundberg
   File Name: main.cpp
   Purpose: PQ and Heap Sort
   Date: 17 July 2014
*/

#include <iostream>
   using namespace std;
#include <cstring>
#include "HeapSort.h"
int main(){
	string n = "-sortexample";
	PQ *name = new PQ(n, n.size());
	cout << "PQ: "; name->printPQ(); cout << endl;
	HeapSort *heap = new HeapSort(name);
	cout << "Heap Unsorted: "; heap->printHeap(); cout << endl;
	heap->heapify();
	cout << "Heap Sorted: "; heap->printHeap(); cout << endl;

	return 0;
}