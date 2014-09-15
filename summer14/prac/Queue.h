/*
 *  Queue.h
 *  Csci41-S13-PQuiz1-Thur
 *
 *  Created by shliu on 2/20/13.
 *  Copyright 2013 __MyCompanyName__. All rights reserved.
 *
 */
/*
 implement a Queue class that has
 1. constructor
 2. destructor
 3. push/enqueue  
 4. pop/dequeue
 5. Linked List as private data member
 
 the above five are required!
 
 You may add more functions or data members to support Queue class 
 */

#ifndef Queue_H
#define Queue_H
#include "LinkedList.h"
class Queue
{
	public:
		Queue(){

		}

		~Queue(){
			
		}

		void enqueue(int item){
			list.push_back(item);
		}

		void dequeue(){
			list.pop_front();
		}

		void print(){
			list.print();
		}
	private:
		LinkedList list;
};
#endif