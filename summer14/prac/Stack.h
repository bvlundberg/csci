/*
 *  Stack.h
 *  Csci41-S13-PQuiz1-Thur
 *
 *  Created by shliu on 2/18/13.
 *  Copyright 2013 __MyCompanyName__. All rights reserved.
 *
 */

/*
  implement a Stack class that has
  1. constructor
  2. destructor
  3. push  
  4. pop
  5. Linked List as private data member
  
 the above five are required!
 
 You may add more functions or data members to support Stack class 
 */
#ifndef STACK_H
#define STACK_H
#include "LinkedList.h"
class Stack
{
	public:
		Stack(){

		}

		~Stack(){

		}

		void push(int item){
			list.push_front(item);
		}

		void pop(){
			list.pop_front();
		}

		void print(){
			list.print();
		}
	private:
		LinkedList list;
};
#endif