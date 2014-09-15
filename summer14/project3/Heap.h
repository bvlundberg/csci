#include "Tree.h"
class Heap{
private:
	Tree *m_heap;
	//int m_size;
public:
	Heap(){
		//m_size = 0;
		m_heap = new Tree();
	}
	~Heap(){}
	// get functions
	Node* getHeapRoot(){return m_heap->getRoot();}
	int getHeapSize(){return m_heap->getSize();}
	// set functions
	void incrementHeapSize(){m_heap->incrementSize();}
	void decrementHeapSize(){m_heap->decrementSize();}
	// other fucntions
	void insertNode(char letter){m_heap->createNode(letter);}
	void removeNode(){m_heap->deleteNode();}
	Node* lookup(char letter){
		Node *p = m_heap->getRoot();
		int lookupResult = 0;
		m_heap->findSearchNode(p, letter, lookupResult);
		cout << "Lookup result for letter " << letter <<": ";
		if(lookupResult)
			cout << "true"<< endl;
		else
			cout << "false" << endl;
	}
	bool isHeap(){
		Node *p = m_heap->getRoot();
		bool ans1 = m_heap->correctValues(p);
		bool ans2 = m_heap->correctStructure(p);
		if(ans1 && ans2)
			cout << "Is Heap" << endl;
		else
			cout << "Is not heap" << endl;
	}
	/* Sibling needs the lookup function to work */
	void sibling(char letter1, char letter2){
		Node *p1 = getHeapRoot();
		int lengthFromRoot1 = length(letter1, p1->getLetter());
		int lengthFromRoot2 = length(letter2, p1->getLetter());
		if(lengthFromRoot1 == lengthFromRoot2 && lengthFromRoot1 > 0)
			cout << "The nodes with the letters " << letter1 << " and " << letter2 << " are siblings." << endl;
		else
			cout << "The nodes with the letters " << letter1 << " and " << letter2 << " are  not siblings or" << endl;
			cout << "one/both of the nodes do not exist." << endl;
			cout << endl;
	}
	int length(char letter1, char letter2){
		int count = 0;
		Node *p1 = getHeapRoot();
		Node *p2 = getHeapRoot();
		p1 = m_heap->findLengthNode(p1,letter1);
		p2 = m_heap->findLengthNode(p2,letter2);
		if(p1 == NULL || p2 == NULL){
			cout << "One or more of these nodes are not in the heap." << endl;
			cout << endl;
			return -1;
		}
		else{
		cout << "Letter 1 Node: " << p1->getLetter() << endl;
		cout << "Letter 2 Node: " << p2->getLetter() << endl;
		while(p1 != NULL){
			if(p1->getLetter() == p2->getLetter())
				break;
			else
				p1 = p1->getParent();
			count++;

		}
		if(p1 == NULL){
			cout << "These nodes are not direct ancestors." << endl;
			cout << endl;
			return -1;
		}
		else{
			cout << "The length between nodes is: " << count << endl;
			cout << endl;
			return count;
		}
		}
	}
};