/*	Author:		Brandon Lundberg
	File Name:	lists.cpp
	Purpose: Holds the abstract classes for a link and linkedlist
	Date: 2 March 2015
*/
#include <cstdlib>
#include "List.h"

template <typename E> class Link{
	private:
		static Link<E> *freeList;
		static int activeNodes;
		static int freeNodes;

	public:
		E element;
		Link *next;

		Link(){
			element = -1;
			next = NULL;
		}
		/*
		Link(Link *nextL = NULL){
			nextLink = nextL;
		}
		*/
		Link(const E& value, Link *nextLink = NULL){
			element = value;
			next = nextLink;
		}
		Link<E>* getHeadFree(){
			return freeList;
		}
		int getActiveNodes(){
			return activeNodes;
		}
		int getFreeNodes(){
			return freeNodes;
		}
		void* operator new(size_t t) { // Overloaded new operator
			if (freeList == NULL){ 
				activeNodes++;
				return :: new Link; // Create space
			}
			Link<E>* temp = freeList; // Can take from freelist
			freeList = freeList->next;
			activeNodes++;
			freeNodes--;
			return temp; // Return the link
		}
		// Overloaded delete operator
		void operator delete(void* ptr) {
			((Link<E>*)ptr)->next = freeList; // Put on freelist
			freeList = (Link<E>*)ptr;
			activeNodes--;
			freeNodes++;
		}

};

template <typename E>
class LinkedList : public List <E> {  
	private:
		Link<E> *head;
		Link<E> *tail;
		Link<E> *curr;

		void init(){
			head = new Link<E>;
			tail = new Link<E>;

			head -> next = tail;
			curr = head;
		}
	public:
		LinkedList(){
			init();
		}
		~LinkedList(){

		}
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
			Link<E> *newNode = new Link<E>(item, head -> next);
			// Set new pointer from head
			head -> next = newNode;
			// Increment nodes in the list
		}

		void append(const E& item){
			// Change tails value
			tail -> element = item;
			// Create a new node that will become tail
			Link<E> *newNode = new Link<E>(item, NULL);
			// Set tails next to the new blank node
			tail -> next = newNode;
			// Change tail, so the new value is in tail's old position
			tail = newNode;
			// Increment nodes in the list
		}

		// Set the current position to the start of the list
	    void moveToStart(){
	    	curr = head;
	    }

	    // Move the current position one step right, if possible;
	    // return true if successful, false if already at the end
	    bool next(){
	    	if(curr -> next != tail){
	    		curr = curr -> next;
	    		return true;
	    	}
	    	return false;
	    }

	    // Return the current element.
	    const E& getValue() const{
	    	return curr -> element;
	    }

		Link<E>* getHead() const{
	    	return head;
	    }
	    // Return total number of active nodes
	    int numActive(){
	    	head -> getActiveNodes();
	    }

	    // Return total number of free nodes
	    int numFree(){
	    	head -> getFreeNodes();
	    }
	    void printList(){
	    	Link<E> *iterator = head -> next;
	    	cout << "Values in the list: ";
	    	while(iterator != tail){
	    		cout << iterator -> element << " ";
	    		iterator = iterator -> next;
	    	}
	    	cout << endl;
	    }




};
