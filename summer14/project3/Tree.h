#include "Node.h"
class Tree{
private:
	Node *m_root;
	int m_size;
public:
	Tree(int size = 0, Node *root = NULL){
		m_root = root;
		m_size = size;
	}
	~Tree(){
	/* Continue to call deleteMax function until all nodes are deleted from the Tree */
	}
// get functions
	Node* getRoot(){return m_root;}
	int getSize(){return m_size;}
// set functions
	void setRoot(Node *newRoot){m_root = newRoot;}	// may not need this function
	void incrementSize(){m_size++;}
	void decrementSize(){m_size--;}
// other functions
	void createNode(char letter){
		incrementSize();
		if(getRoot() == NULL){
			cout << "First size: " << getSize() << endl;
;			Node *newNode = new Node(letter);
			setRoot(newNode);
			cout << "First root: " << newNode->getLetter() << endl;
		}
		else{
		Node *p = getRoot();
		int max = getSize();
		cout << "Current size: " << getSize() << endl;
		findAddNode(p, 1, max, letter);
		}
	}
	void deleteNode(){
		if(getRoot() == NULL)
			return;
		else{
			Node *p = getRoot();
			int max = getSize();
			findDeleteNode(p, 1, max);
		}
	}

	bool correctStructure(Node *p){
		if(p == NULL) return true;
		else if(depth(p->getrChild()) > depth(p->getlChild())) return false;
		else if(depth(p->getlChild()) > depth(p->getrChild()))
			if(depth(p->getlChild()) != 1 + depth(p->getrChild())) return false;
		else return (correctStructure(p->getlChild()) && correctStructure(p->getrChild()));
		else return true;
	}

	bool correctValues(Node *p){
		if(p == NULL) return true;
		else if(p->getlChild() == NULL && p->getrChild() != NULL)
			if(p->getrChild()->getLetter() > p->getLetter()) return false;
		else if(p->getlChild() != NULL && p->getrChild() == NULL)
			if(p->getlChild()->getLetter() > p->getLetter()) return false;
		else{
			if(p->getLetter() > p->getlChild()->getLetter() && p->getLetter() > p->getrChild()->getLetter()){
				if(!correctValues(p->getrChild()) || !correctValues(p->getlChild()))
					return true;
				else
					return false;
			}
		}
		return true;	
	}
	int depth(Node *p){
		if(p == NULL) return -1;
		else{
			int depthLeft = depth(p->getlChild());
			int depthRight = depth(p->getrChild());
			if(depthLeft > depthRight) return 1 + depthLeft;
			else return 1 + depthRight;
		}
	}
	void findSearchNode(Node *p, char letter, int &lookupResult){
		//cout << "Current letter: " <<p->getLetter() << endl;
		if(p->getLetter() == letter){
			lookupResult = 1;
		}
		else{
			if(p->getlChild() != NULL)
				findSearchNode(p->getlChild(), letter, lookupResult);
			if(p->getrChild() != NULL)
				findSearchNode(p->getrChild(), letter, lookupResult);
		}

		//return false;
	}
	void findAddNode(Node *p, int x, int max, char letter){
		cout << "Current letter: " <<p->getLetter() << endl;
		if(x * 2 > max)	return;
		else if(x * 2 == max){
			Node *newNode = new Node(letter, p);
			p->setlChild(newNode);
			cout<< "Added left letter: " << newNode->getLetter() << endl;
			swim(newNode);
			return;
		}
		else if((x * 2)+1 == max){
			Node *newNode = new Node(letter, p);
			p->setrChild(newNode);
			cout<< "Added right letter: " << newNode->getLetter() << endl;
			swim(newNode);
			return;
		}
		else{
			findAddNode(p->getlChild(), x*2, max, letter);
			findAddNode(p->getrChild(), (x*2)+1, max, letter);
		}
	}
	void findDeleteNode(Node *p, int x, int max){
		//cout << "Current letter: " <<p->getLetter() << endl;
		if(x == max){
			cout << "deleted node with letter: " << getRoot()->getLetter() << endl;
			delete p;
			decrementSize();
			setRoot(NULL);
		}
		else if(x * 2 > max)	return;
		else if(x * 2 == max){
			cout << "deleted node with letter: " << getRoot()->getLetter() << endl;
			swaps(p->getlChild(), getRoot());
			delete  p->getlChild();
			p->setlChild(NULL);
			//cout<< "Added left letter: " << newNode->getLetter() << endl;
			decrementSize();
			cout << "Sink letter: " << getRoot()->getLetter() << endl;
			sink(getRoot());
			return;
		}
		else if((x * 2)+1 == max){
			cout << "deleted node with letter: " << getRoot()->getLetter() << endl;
			swaps(p->getrChild(), getRoot());
			delete  p->getrChild();
			p->setrChild(NULL);
			//cout<< "Added left letter: " << newNode->getLetter() << endl;
			decrementSize();
			cout << "Sink letter: " << getRoot()->getLetter() << endl;
			sink(getRoot());
			return;
		}
		else{
			findDeleteNode(p->getlChild(), x*2, max);
			findDeleteNode(p->getrChild(), (x*2)+1, max);
		}
	}
	Node* findLengthNode(Node *p, char letter){
		//cout << "Current letter: " <<p->getLetter() << endl;
		if(p == NULL) return NULL;
		if(p->getLetter() == letter){
			return p;
		}
		else if(p->getlChild() == NULL && p->getrChild() == NULL)
			return NULL;
		else {
			Node *newp1 = findLengthNode(p->getlChild(), letter);
			Node *newp2 = findLengthNode(p->getrChild(), letter);
			if(newp1 != NULL)
				return newp1;
			else return newp2;
		}

		//return false;
	}
	// sink a node to the correct spot in the heap
	void sink(Node *newNode){
		if(newNode->getlChild() == NULL){
			//cout << "Children Null" << endl;
			return;
		} 	// If left child is NULL, then the right child should be null as well, due to max heap properties
		else if(newNode->getrChild() == NULL)		// case where a node only has a left child
			if(newNode->getlChild()->getLetter() > newNode->getLetter()){
				swaps(newNode->getlChild(), newNode);
				return;
			}
			else return;
		else if(newNode->getLetter() > newNode->getlChild()->getLetter() && newNode->getLetter() > newNode->getrChild()->getLetter()) return;	// case where the node is bigger than both children
		else if(newNode->getlChild()->getLetter() > newNode->getrChild()->getLetter()){
			swaps(newNode, newNode->getlChild());
			sink(newNode->getlChild());
		}
		else if(newNode->getlChild()->getLetter() < newNode->getrChild()->getLetter()){
			swaps(newNode, newNode->getrChild());
			sink(newNode->getrChild());
		}
	}
	// swim a node to the correct spot in the heap
	void swim(Node *newNode){
		if(newNode->getParent() == NULL) return;
		else if(newNode->getLetter() > newNode->getParent()->getLetter()){
			cout << "Swap by swim-- Higher letter: " << newNode->getLetter() << " Lower letter: " << newNode->getParent()->getLetter()<< endl;
			swaps(newNode,newNode->getParent());
			swim(newNode->getParent());
		}
	}
	// swap the contents of two nodes
	void swaps(Node *highNode, Node *lowNode){
		Node *temp = new Node(highNode->getLetter());	
		highNode->setLetter(lowNode->getLetter());		
		lowNode->setLetter(temp->getLetter());

		delete temp;
	}
};