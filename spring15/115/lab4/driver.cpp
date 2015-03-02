/*	Author:		Brandon Lundberg
	File Name:	driver.cpp
	Purpose: Runs the test cases for the linked list implementation
	Date: 23 February 2015
*/
#include <cstdlib>      /* printf, NULL */
#include <iostream>
using namespace std;

#include "lists.cpp"
	template <typename E> int 		Link<E>::activeNodes = -2;
	template <typename E> int 		Link<E>::freeNodes = 0;
	template <typename E> Link<E>* 	Link<E>::freeList = NULL;
int main(){
	//Link<E>* Link<E>::freelist = NULL;
	LinkedList<int> l;
	// Test 1 -- Initial values
	cout << "This is to test initialization of the list" << endl << \
			"The following test should have the following values" << endl << \
			"Link Values: Empty" << endl << \
			"Active nodes: 0" << endl << \
			"Free nodes: 0" << endl << \
			"The following are the resulting values of the function calls" << endl;
	l.printList();
	cout << "Number of active nodes: " << l.numActive() << endl;
	cout << "Number of free nodes: " << l.numFree() << endl << endl;

	// Test 2 -- inserting links to the list
	l.append(3);
	l.append(4);
	l.append(5);
	l.prepend(2);
	l.prepend(1);
	cout << "This is to test inserting links into the list" << endl << \
			"The following test should have the following values" << endl << \
			"Link Values: 1 2 3 4 5" << endl << \
			"Active nodes: 5" << endl << \
			"Free nodes: 0" << endl << \
			"The following are the resulting values of the function calls" << endl;
	l.printList();
	cout << "Number of active nodes: " << l.numActive() << endl;
	cout << "Number of free nodes: " << l.numFree() << endl << endl;

	// Test 3 -- clearing the list
	l.clear();
	cout << "This is to test that the list emptied and that the free list is occupied" << endl << \
			"The following test should have the following values" << endl << \
			"Link Values: Empty" << endl << \
			"Active nodes: 0" << endl << \
			"Free nodes: 5" << endl << \
			"The following are the resulting values of the function calls" << endl;
	l.printList();	
	cout << "Number of active nodes: " << l.numActive() << endl;
	cout << "Number of free nodes: " << l.numFree() << endl << endl;

	// Test 4 -- Adding links to the list after clearing
	l.append(6);
	l.prepend(3);
	l.append(9);
	cout << "This is to test inserting links into the list after clearing it" << endl << \
			"The following test should have the following values" << endl << \
			"Link Values: 3 6 9" << endl << \
			"Active nodes: 3" << endl << \
			"Free nodes: 2" << endl << \
			"The following are the resulting values of the function calls" << endl;
	l.printList();	
	cout << "Number of active nodes: " << l.numActive() << endl;
	cout << "Number of free nodes: " << l.numFree() << endl << endl;

	// Test 5 -- Test moveToFront, next, and get value functions
	cout << "This is to test move to front, next and get value functions " << endl << \
			"The following test should have the following values" << endl << \
			"Link value: 3" << endl << \
			"Call next" << endl << \
			"Link value: 6" << endl << \
			"Call next" << endl << \
			"Link value: 9" << endl << \
			"Call next" << endl << \
			"Link value: 9 (next on last element will not go to tail)" << endl << \
			"The following are the resulting values of the function calls" << endl;
	l.printList();	
	l.moveToStart();
	l.next();
	cout << "Value: " << l.getValue() << endl;
	l.next();
	cout << "Value: " << l.getValue() << endl;
	l.next();
	cout << "Value: " << l.getValue() << endl;
	l.next();
	cout << "Value: " << l.getValue() << endl;
	l.clear();

	return 0;
}
