#include "Node.h"
class DLL{
private:
	Node *m_first;
	Node *m_last;
	int m_size;
public:
	// Constructor
	DLL(int size = 1, Node *first = NULL, Node *last = NULL){
		m_size = size;
		m_first = first;
		m_last = last;
	}
	// Destructor
	~DLL(){
		Node *p;
		p = getFirst();
		while(p != NULL){
			p = getFirst();
			setFirst(getFirst()->getNext());
			delete p;
		}
	}								
	// Get functions
	int getSize(){return m_size;}
	int getFirstID(){return m_first->getID();}
	Node* getFirst(){
		if(m_first != NULL)
			return m_first;
		else
			return 0; 
	}
	Node* getLast(){return m_last;}
	// Set functions
	void setSize(int size){m_size = size;}
	void incrementSize(){m_size++;}
	void decrementSize(){m_size--;}
	void setFirst(Node *first){m_first = first;}
	void setLast(Node *last){m_last = last;}
	void createNode(int id, int enteringTime, int executionTime){
		if(getFirst() == NULL){
			Node *newNode = new Node(id,enteringTime,executionTime);
			setFirst(newNode);
			setLast(newNode);
			incrementSize();
		}
		else{
			Node *newNode = new Node(id, enteringTime, executionTime, getFirst(), NULL);
			(newNode->getNext())->setPrev(newNode);
			setFirst(newNode);
			incrementSize();

		}
	}
	void deleteFirst(){
		Node *p = m_first;
		m_first = m_first->getNext();
		delete p;
	}
	void shellSort(){
			int interval = 1;		// Increase interval
			while(interval < getSize() - 3){interval += 3;}
			// Run Sort
			while(interval >= 1){
				Node *p = getFirst();
				p = jumpForward(p, interval);		// Move p to interval
				for(p; p != NULL; p = p->getNext()){
					Node *q = p;						
					Node *qCheck = q;				// qcheck will act as q - interval
					qCheck = jumpBack(qCheck,interval);
					// The second check in this while loop is used if two elements have the same
					// execution time, the one with the lower ID number will move down in the DLL
					while((qCheck != NULL && lessThan(qCheck, q)) || (qCheck != NULL && qCheck->getExecutionTime() == q->getExecutionTime() && qCheck->getID() > q->getID())){
						swaps(qCheck,q);
						// Move q and qcheck back
						q = jumpBack(q,interval);
						qCheck = jumpBack(qCheck,interval);
					}	
				}	
			interval -= 3;		// Decrease interval
			}
	}
	void quickStart(){
		// This function initializes the parameters to be sorted
		Node *low = getFirst();
		Node *high = getLast();
		quickSort(low, high);
	}

	void quickSort(Node *low, Node *high){
		Node *mid = partition(low, high);
		// These checks are in place to make sure high is not less than or equal to low
		if(mid->getPrev() != low->getPrev() && mid->getPrev() != low)
			quickSort(low, mid->getPrev());
		if(mid->getNext() != high->getNext() && mid->getNext() != high)
			quickSort(mid->getNext(), high);

	}

	Node* partition(Node *low, Node *high){
		Node *pivot = low;	// Set pivot to first element
		low = low->getNext();	// Increment low
		// Check on while loop to make sure high is not less than or equal to low
		while(high->getNext() != low && high != low){
			while(low->getExecutionTime() < pivot->getExecutionTime()){
				if(low->getNext() == high->getNext()){break;}	// Check low does not pass high
				low = low->getNext();
			}			
			while(high->getExecutionTime() > pivot->getExecutionTime()){
				if(high->getPrev() == pivot->getPrev()){break;}	// Check high does not pass pivot
				high = high->getPrev();
			}
			if(high != low && high->getNext() != low)	// Check high is not less than or equal to low
				swaps(low, high);
		}
		if(pivot->getExecutionTime() == high->getExecutionTime() && pivot->getID() > high->getID())	// If execution times are equal and pivot ID is greater than high ID, still want lower ID to move down
			swaps(high, pivot);
		else if(pivot->getExecutionTime() > high->getExecutionTime())	// swap pivot and high if pivot > high
			swaps(high, pivot);
		return high;
	}

	Node* jumpForward(Node *moveForward, int interval){
		for(int x = 0; x < interval; x++){
			moveForward = moveForward->getNext();
			if (moveForward == NULL){break;}
		}
		return moveForward;
	}

	Node* jumpBack(Node *moveBack, int interval){
		for(int x = 0; x < interval; x++){
			moveBack = moveBack -> getPrev();
			if (moveBack == NULL){break;}
		}
		return moveBack;
	}

	bool lessThan(Node *qCheck, Node *q){
		if(q->getExecutionTime() < qCheck->getExecutionTime())
			return true;
		else
			return false;
	}
	void swaps(Node *lower, Node *higher){
		Node *temp = new Node(lower->getID(),lower->getEnteringTime(),lower->getExecutionTime());
		lower->setID(higher->getID());
		lower->setEnteringTime(higher->getEnteringTime());
		lower->setExecutionTime(higher->getExecutionTime());
		higher->setID(temp->getID());
		higher->setEnteringTime(temp->getEnteringTime());
		higher->setExecutionTime(temp->getExecutionTime());

		delete temp;
	}

	void printDLL(){
		Node *p = getFirst();
		while(p != NULL){
			cout << p->getID() << " " << p->getEnteringTime() << " " << p->getExecutionTime() << endl;
			p = p->getNext();
		}
		cout << endl;
	}
};