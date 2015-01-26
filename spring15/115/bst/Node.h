/*	Author: Brandon Lundberg
	File Name: Node.h
	Purpose: Implementing node class for a BST
	Date: 24 Jan 2015
*/

class Node
{
private:
	int m_value;
	Node *m_rChild;
	Node *m_lChild;
public:
	// Node constructor and destructor
	Node(){}
	Node(int value){
		m_value = value;
		m_rChild = NULL;
		m_lChild = NULL;
	}
	~Node(){
		m_rChild = NULL;
		m_lChild = NULL;
	}
	// Get and Set functions for class members
	int getValue(){
		return m_value;
	}
	void setValue(int newValue){
		m_value = newValue;
	}
	Node* getrChild(){
		return m_rChild;
	}
	void setrChild(Node *newRightChild){
		m_rChild = newRightChild;
	}
	Node* getlChild(){
		return m_lChild;
	}
	void setlChild(Node *newLeftChild){
		m_lChild = newLeftChild;
	}	
};

