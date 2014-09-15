/*
 *  Node.h
 *  Csci41-S13-PQuiz1-Thur
 *
 *  Created by shliu on 2/18/13.
 *  Copyright 2013 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef NODE_H
#define NODE_H
class Node
{
public:
	Node(Node* n = NULL, int v =0)
	{
		next = n;
		value = v;
	}
	
	//int getValue() {return value; }
	//void setValue(int v) { value  = v; }
	//void setNext(Node* n) { next = n; }
	//Node* getNext() { return next; }
//private: this is a bad practice. just for convenience.
	Node* next;
	int value;
};
#endif