/*

 CSCI 41-S13 Programming Quiz 1, Wed Lab
 1. Implement a Stack class and 2 functions of LinkedList class. Please read the meaning of each class/function in specific files.
 2. Introduce a function called isPalindrome and invoke it in main function. 
 The purpose of isPalindrome is to store a sequence of integer. And you may use what you implement from (1) to determine if the
 sequence is Palindrome or not.
 
 The definition of Palindrome is as this: abba or abcba (reading from front to back and reading from back to front, they are the same).
*/

#include <iostream>
#include "LinkedList.h"
#include "Stack.h"
#include "Queue.h"
using namespace std;
int main (int argc, char * const argv[]) {
	
	LinkedList* list = new LinkedList();
	
	list->push_front(8);
	list->push_front(2);
	list->push_front(10);
	list->push_front(7);
	list->print();
	list->pop_back();
	list->pop_front();
	list->print();
	list->push_back(10);
	list->push_back(12);
	list->print();

	//Seg Fault Here
	list->deleteNodesSmallerThan(11);
	list->print();
    
    Stack* pile = new Stack();
    cout << "Stack" << endl;
    pile->push(5);
    pile->push(1);
    pile->push(2);
    pile->pop();
    pile->print();

    Queue* line = new Queue();
    cout << "Queue" << endl;
    line->enqueue(7);
    line->enqueue(9);
    line->enqueue(4);
    line->dequeue();
    line->print();
	
	return 0;
}