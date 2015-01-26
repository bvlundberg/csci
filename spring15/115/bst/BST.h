/*	Author: Brandon Lundberg
	File Name: BST.h
	Purpose: Implementing BST class
	Date: 24 Jan 2015
*/

class BST{
private:
	Node *m_root;
public:
	// BST constructor and destructor
	BST(){
		m_root = NULL;
	}
	~BST(){}
	// Get and set functions for BST
	Node* getRoot(){
		return m_root;
	}
	void setRoot(Node *newRoot){
		m_root = newRoot;
	}
	// Insert a new Node into the tree
	/*
	void insert_node(int value){
		Node newNode = new Node(value);

		if(getRoot() == NULL){
			setRoot(newNode);
		}

		if(newNode->)

	}
	*/
	/* data */
};