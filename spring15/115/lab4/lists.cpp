/*	Author:		Brandon Lundberg
	File Name:	lists.cpp
	Purpose: Holds the abstract classes for a link and linkedlist
	Date: 23 February 2015
*/
#include <cstdlib>
#include "List.h"

template <typename E> class Link{
	private:
		static Link *freeList;
		static int activeNodes;
		static int freeNodes;

	public:
		E element;
		Link *next;
		Link(const E& value, Link *nextLink = NULL){
			element = value;
			next = nextLink;
		}

};

/*
template <typename E> class Link {
	public:
		E element; // Value for this node
		Link *next; // Pointer to next node in list
		// Constructors
		Link(const E& elemval, Link* nextval = NULL)
		{ element = elemval; next = nextval; }
		Link(Link* nextval =NULL) { next = nextval; }
};
*/
template <typename E>
class LinkedList : public List <E> {  
	private:
		Link<E> *head;
		Link<E> *tail;
		Link<E> *curr;
	public:
		void clear(){
			Link<E> *iterator = head->next;
			while(head->next != tail){
				// Change next pointer
				head -> next = iterator -> next;
				delete iterator;
				iterator = head -> next;
				// Free node
			}
			curr = head;
		}

		void prepend(const E& item){
			// Create new node with value
			Link<E> *newNode = new Link<E>(&item, head -> next);
			// Set new pointer from head
			head -> next = newNode;
			// Increment nodes in the list
		}

		void append(const E& item){
			// Change tails value
			tail -> element = &item;
			// Create a new node that will become tail
			Link<E> *newNode = new Link<E>(NULL);
			// Set tails next to the new blank node
			tail -> next = newNode;
			// Change tail, so the new value is in tail's old position
			tail = newNode;
			// Increment nodes in the list
		}




};
