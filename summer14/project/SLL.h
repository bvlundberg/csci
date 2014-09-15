#include "Node.h"

class SLL{
private:
	Node *m_first;		// First element of the SLL
	Node *m_last;		// Last element of the SLL
	int m_nodeCount;	// Size of all the elements of the SLL
public:
	SLL(){
		m_first = NULL;
		m_last = NULL;
		m_nodeCount = 0;
	}
	~SLL(){}
	
	// Get functions
	Node* getFirst(){return m_first;}
	Node* getLast(){return m_last;}
	int getCount(){return m_nodeCount;}
	// Set functions
	void setFirst(Node *elem){m_first = elem;}
	void setLast(Node *elem){m_last = elem;}
	void setCount(int count){m_nodeCount = count;}
	void incrementCount(){m_nodeCount++;}	// Increase the size of the elements in the array by 1
	void decrementCount(){m_nodeCount--;}	// Decrease the size of the elements in the array by 1
	// Other functions
	void createNode(int xCoef, int xDeg, int yDeg){
		if(getFirst() == NULL){
			Node *newNode = new Node(xCoef, xDeg, yDeg);
			setFirst(newNode);
			setLast(newNode);
			incrementCount();
		}
		else{
			Node *newNode = new Node(xCoef, xDeg, yDeg);
			// Update
			Node *p = getFirst();
			Node *connect = p;
			int termination = 0;
			while(p != NULL){
				if((newNode->getxDeg() + newNode->getyDeg()) >= (p->getxDeg() + p->getyDeg())){
					if(newNode->getxDeg() > p->getxDeg()){
						if (p == getFirst()){
							setFirst(newNode);
							getFirst()->setNext(p);
							termination = -1;
							break;
						}
						else{
							newNode->setNext(p);
							connect->setNext(newNode);
							termination = -1;
							break;
						}
					}
					else if(newNode->getxDeg() == p->getxDeg() && newNode->getyDeg() > p->getyDeg()){
							if (p == getFirst()){
							setFirst(newNode);
							getFirst()->setNext(p);
							termination = -1;
							break;
						}
						else{
							newNode->setNext(p);
							connect->setNext(newNode);
							termination = -1;
							break;
						}
					}
					else{
						if(p == connect)
							p = p->getNext();
						else{
							p = p->getNext();
							connect = connect->getNext();
						}
					}
					
				}

				else{
					if(p == connect)
						p = p->getNext();
					else{
						p = p->getNext();
						connect = connect->getNext();
					}
				}
			}

			if(termination != -1){
				newNode->setNext(NULL);
				connect->setNext(newNode);
			}
			//m_last->setNext(newNode);
			//setLast(newNode);
			incrementCount();
		}
	}
	void enterInfo(int polyNumber){
		int xCoef, xDeg, yDeg, cont = 0;
		cout << "Enter the information for the 1st element " <<
				"of the number " << polyNumber << " polynomial" << endl << "with spaces in between" << endl;
		cout << "(x coefficient x degree y degree): ";
		cin >> xCoef >> xDeg >> yDeg;
		createNode(xCoef, xDeg,yDeg);
		cout << "Enter another element?(enter 0 to quit or 1 to continue): ";
		cin >> cont;
		while(cont != 0){
			cout << "Next element: ";
			cin >> xCoef >> xDeg >> yDeg;
			createNode(xCoef, xDeg, yDeg);
			cout << "Enter another element? (enter 0 to quit or 1 to continue): ";
			cin >> cont;
		}
	}

	int degree(){
		Node *p;
		p = getFirst();
		int maxDegree;
		while(p->getxCoef() == 0){p = p->getNext();}
		maxDegree = p->getxDeg() + p->getyDeg();
		while(p != NULL){
			if(p->getxDeg() + p->getyDeg() > maxDegree && p->getxCoef() != 0)
				maxDegree = p->getxDeg() + p->getyDeg();
			p = p->getNext();
		}
		return maxDegree; 
	}

	int coefficient(int elem){
		Node* p;
		p = getFirst();
		for(int i = 1; i < elem; i++){
			p = p->getNext();
		}
		return p->getxCoef();
	}

	bool match(SLL *checkPoly){
		Node *p;
		p = getFirst();
		Node *pCheck;
		pCheck = checkPoly->getFirst();
		while(p != NULL){
			if(pCheck == NULL){
				return false;
			}
			if(p->getxCoef() == pCheck->getxCoef()){
				if(p->getxDeg() == pCheck->getxDeg()){
					if(p->getyDeg() == pCheck->getyDeg()){
						p = p->getNext();
						pCheck = pCheck->getNext();
					}}}
			else{
				return false;
			}
		}
		if(pCheck != NULL)
			return false;
		else
			return true;
	}

	SLL* sum(SLL *addedSLL){
		SLL *newSLL = new SLL();
		Node *p, *pCheck;
		p = getFirst();
		while(p != NULL){
			newSLL->createNode(p->getxCoef(), p->getxDeg(), p->getyDeg());
			p = p->getNext();
		}
		p = addedSLL->getFirst();
		while(p != NULL){
			newSLL->createNode(p->getxCoef(), p->getxDeg(), p->getyDeg());
			p = p->getNext();
		}

		replaceContents(newSLL);
		delete newSLL;
		
		int j = getCount();
		for(int i = 0; i < j; i++){
			simplify();
		}
	
	
	}
	
	SLL* dot(SLL *dotSLL){
		SLL *newSLL = new SLL();
		Node *p;
		Node *pCheck;
		int xCoef, xDeg, yDeg;
		p = getFirst();
		while(p != NULL){
		pCheck = dotSLL->getFirst();
		while(pCheck != NULL){
			xCoef = p->getxCoef() * pCheck->getxCoef();
			xDeg = p->getxDeg() + pCheck->getxDeg();
			yDeg = p->getyDeg() + pCheck->getyDeg();
			newSLL->createNode(xCoef, xDeg, yDeg);
			pCheck = pCheck->getNext();
		}
			p = p->getNext();
		}

		replaceContents(newSLL);
		delete newSLL;

		int j = getCount();
		for(int i = 0; i < j; i++){
			simplify();
		}

	}
	void simplify(){
		Node *p;
		Node *pCheck;
		int termination = 0;	// This variable is used to finish the function if a node is deleted
		p = getFirst();
		while(p->getNext() != NULL){
			pCheck = p->getNext();
			while(pCheck != NULL){
				if(p->getxDeg() == pCheck->getxDeg() && p->getyDeg() == pCheck->getyDeg()){
					p->setxAddCoef(p->getxCoef(), pCheck->getxCoef());
					Node *connect;
					connect = p;
					while(connect->getNext() != pCheck){connect = connect->getNext();}
					connect->setNext(pCheck->getNext());
					delete pCheck;
					pCheck = NULL;
					decrementCount();
					termination = -1;
					break;
				}
				else
					pCheck = pCheck->getNext();
			}
			if(termination == -1)
				break;
			p = p->getNext();
		}
	}
	void replaceContents(SLL *newSLL){
		Node *p;
		while(getFirst() != NULL){
			p = getFirst();
			setFirst(getFirst()->getNext());
			delete p;
			p = NULL;
		}
		setFirst(newSLL->getFirst());

	}
	void printSLL(int polyNumber){
		Node *p;
		p = getFirst();
		int i = 1;
		cout << "Polynomial " << polyNumber << endl;
		while(p != NULL){
			cout << "Element " << i << ": ";
			cout << p->getxCoef()<< " " << p->getxDeg() << " " << p->getyDeg()<< endl;
			p = p->getNext();
			i++;
		}
	}
};