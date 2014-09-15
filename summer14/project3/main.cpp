/*	Author: Brandon Lundberg
	File Name: main.cpp
	Purpose: Main function for Project 3
	Date: 27 July 2014
*/
#include <iostream>
	using namespace std;
#include "Heap.h"

int main(){
	//Tree *maxTree = new Tree();
	//maxTree->createNode('s');
	//maxTree->createNode('a');
	Heap *maxHeap = new Heap();
	//
	cout << "Insert all nodes--" << endl;
	maxHeap->insertNode('b');
	maxHeap->insertNode('r');
	maxHeap->insertNode('a');
	maxHeap->insertNode('n');
	maxHeap->insertNode('d');
	maxHeap->insertNode('o');
	cout << endl;

	cout << "Is heap check--" << endl;
	maxHeap->isHeap();
	cout << endl;

	cout << "Lookup examples--" << endl;
	maxHeap->lookup('r');
	maxHeap->lookup('b');
	maxHeap->lookup('d');
	maxHeap->lookup('x');
	cout << endl;

	cout << "Length examples--" << endl;
	maxHeap->length('a','r');
	maxHeap->length('d','n');
	maxHeap->length('n','o');
	maxHeap->length('b','x');
	cout << endl;

	cout << "Sibling examples--" << endl;
	maxHeap->sibling('a','b');
	maxHeap->sibling('n','o');
	maxHeap->sibling('a','r');
	maxHeap->sibling('a','x');
	cout << endl;

	cout << "Remove all nodes--" << endl;
	maxHeap->removeNode();
	maxHeap->removeNode();
	maxHeap->removeNode();
	maxHeap->removeNode();
	maxHeap->removeNode();
	maxHeap->removeNode();
	cout << endl;

	delete maxHeap;
	return 0;
}