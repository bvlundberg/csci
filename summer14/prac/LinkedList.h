/*
 *  LinkedList.h
 *  Csci41-S13-PQuiz1-Thur
 *
 *  Created by shliu on 2/18/13.
 *  Copyright 2013 __MyCompanyName__. All rights reserved.
 *
 */
/*
 implement a *Singly* Linked List class that has
 
 1. pop_front: delete from the front of the linked list  
 2. pop_back: delete the last node of the linked list
 3. front as a data member points to its first node
  
 the above four are required!
 
 You may add more functions or data members to support Stack class 
 */
#ifndef LinkedList_H
#define LinkedList_H
#include "Node.h"
#include <iostream>
using namespace std;
class LinkedList
{

public:
	LinkedList()
	{
		front = NULL;
		back = NULL;
		size = 0;
	}
	void push_front(int item)
	{
		if (front == NULL)
		{
			front = new Node(NULL, item);
			back = front;
			size++;
			return; 
		}
		
		Node* newNode = new Node(NULL, item);
		newNode->next = front;
		front = newNode;
		size++;
		
	}
	
	int pop_front()
	{
		Node* dNode;
		dNode = front;
		front = front->next;
		delete dNode;
		size--;
	}
	
	int pop_back()
	{
		Node* dNode;
		dNode = front;
		while(dNode != back){
			dNode = dNode->next;
		}
		Node* prev;
		prev = front;

		while(prev->next != back){
			prev = prev->next;
		}
		
		delete dNode;

		back = prev;
		size--;		
	}
	void push_back(int item)
	{
		if (back == NULL)
		{
			back = new Node(NULL, item);
			front = back;
			size++;
			return; 
		}

		Node* newNode = new Node(NULL, item);
		back->next = newNode;
		back = newNode;
		size++;
	}
	void deleteNodesSmallerThan(int item){
		int const newSize = size;
		for(int index = 0; index < newSize; index++){
			Node *current;
			Node *prev;
			current = front;
			prev = front;
			while(current != NULL){
				if(current->value < item){
					cout << current->value << endl;
					if(current == front){ 
						front = front->next;
						delete current;
						size--;
						break;
					}
					else if(current == back){
						back = prev;
						prev->next = NULL;
						delete current;
						size--;
						break;
					}
					else{
						prev->next = current->next;
						delete current;
						size--;
						break; 
					}

				}
				else{
					prev = current;
					current = current->next;
				}
			}
			}
		//}


	}

	
	void print()
	{
		Node* pNode;
		pNode = front;
		for(int i = 0; i < size; i++){
			cout << "The value of this node is: " << pNode->value << endl;
			
			pNode = pNode->next;
		}
		cout << "Size of Linked List: " << size << endl;
	}	
//private:
	Node* front; //front of a linked list
	Node* back;
	int size; //# of nodes in a linked list
};
#endif