// Lab 3

/*
Author: Brandon Lundberg
File Name: node.h
Purpose: Singly Linked List
Date: 25 June 2014
*/

#ifndef NODE_H
#define NODE_H

class Node
{
private:
	double m_value;
	Node *m_next;

public:
	Node(){
		m_value = 0;
		m_next = NULL;
	}
	Node(double value){
		m_value = value;
		

	}
	int getValue(){
		return m_value;
	}
	void setValue(int value){
		m_value = value;
	}
	Node* getNext(){
		return m_next;
	}
	void setNext(Node* next){
		m_next = next;
	}




};

#endif // !NODE_H