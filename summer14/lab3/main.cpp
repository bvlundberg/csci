// Lab 3

/*
Author: Brandon Lundberg
File Name: main.cpp
Purpose: Singly Linked List
Date: 25 June 2014
*/
#include <iostream>
using namespace std;

#include "node.h"
#include "sll.h"


int main (){
	SLL list1 = SLL();
	list1.insertToTail(9);
	list1.insertToTail(3);
	list1.insertToTail(6);
	list1.insertToTail(1);
	list1.insertToTail(4);

	list1.printAll();
	
	Node* minimum_ptr = new Node();
	minimum_ptr = list1.findMinimum();
	cout << "The value of the minimum node is: " << minimum_ptr->getValue() << endl;
	
	double target = 6;
	
	list1.deleteNode(target);
	list1.printAll();


	int size = list1.getSize();
	for(int i = 0; i < size; i++){
		list1.deleteAscending();
		list1.printAll();
	}

	return 0;
}