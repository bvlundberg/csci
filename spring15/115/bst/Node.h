/*	Author: Brandon Lundberg
	File Name: Node.h
	Purpose: Implementing node class for a BST
	Date: 24 Jan 2015
*/

class Node
{
private:
	int m_value;
	Node *rChild;
	Node *lChild;
public:
	// Node constructor and destructor
	Node(int value){
		m_value = value;
		rChild = null;
		lChild = null;
	}
	~Node(){
		rChild = null;
		lChild = null;
	}
	// Get and Set functions for class members
	int getValue(){
		return m_value;
	}
	void setValue(int newValue){
		m_value = newValue;
	}
	Node* getrChild(){
		return rChild;
	}
	void setrChild(Node *newRightChild){
		rChild = newRightChild;
	}
	Node* getlChild(){
		return lChild;
	}
	void setlChild(Node *newLeftChild){
		lChild = newLeftChild;
	}	
};

