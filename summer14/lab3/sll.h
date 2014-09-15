// Lab 3

/*
Author: Brandon Lundberg
File Name: sll.h
Purpose: Singly Linked List
Date: 25 June 2014
*/

#ifndef SLL_H
#define SLL_H

class SLL
{
private:
	int m_size;
	Node *front;
	Node *tail;
public:
	SLL(){
		m_size = 0;
		front = NULL;
		tail = NULL;
	}
	~SLL()
	{
		//int size = getSize();
		//for (int i = 0; i < size; i++)
		//	d
	}
	int getSize(){
		return m_size;
	}
	void printAll(){
		Node *p = NULL;
		for(p = front; p != NULL; p = p->getNext())
		{
			cout << "The value of this node is: " << p->getValue() << endl;
		}
		cout << "The size of the linked list is: " << m_size << endl;
	}

	Node* findMinimum(){
		Node* minimum = new Node();
		Node* p = new Node();
		minimum = front;
		p = minimum->getNext();
		while(p != NULL){
			if(p->getValue() < minimum->getValue())
				minimum = p;
			p = p->getNext();
		}
		return minimum;
	}

	void deleteAscending(){
		Node* dNode;
		Node* p;
		Node* prev;
		p = front;
		prev = NULL;

		while(p != NULL){
			if (p == front)
				dNode = p;
			if (p->getValue() < dNode->getValue()){
				dNode = p;
				//while(prev->getNext() != dNode){
				//	prev->setNext(prev->getNext());
				//}

			}
				p = p->getNext();
			}

		
		if(dNode == front){
			front->setNext(front->getNext());
			deleteNode(dNode->getValue());
		}
		else if(dNode == tail){
			//prev->setNext(NULL);
			//tail = prev;
			deleteNode(dNode->getValue());
		}
		else{
			//prev->setNext(dNode->getNext());
			deleteNode(dNode->getValue());
		}

	}

	void deleteNode(int target){
		Node* tNode;
		Node* p;
		p = front;
		if(p->getValue() == target){
			front = p->getNext();
			delete p;
		}

		while(p->getNext() != NULL){
			tNode = p->getNext();
			if (tNode->getValue() == target){
				p->setNext(tNode->getNext());
				delete tNode;
				m_size--;
			}
			if(p->getNext())
				p = p->getNext();
			else break;
			}
		}
	
	void insertToTail(int item){
		Node* p = new Node();
		p->setValue(item);
		if(tail == NULL){
			front = p;
			tail = p;
		}
		else{
			p->setNext(NULL);
			tail->setNext(p);
			tail = p;
			}
		m_size++;
	}

	void deleteFront(){
		Node* dNode;// = new Node();
		Node* p;// = new Node();
		Node* prev;// = new Node();
		dNode = front;
		prev = NULL;
		
		if(dNode == front){
			front->setNext(front->getNext());
			deleteNode(dNode->getValue());
		}
	}
};

#endif // !SLL_H