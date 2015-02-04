/*	Author: Brandon Lundberg
	File Name: BST.h
	Purpose: Implementing BST class
	Date: 24 Jan 2015
*/

class BST{
private:
	Node *m_root;
	int m_numNodes;
public:
	// BST constructor and destructor
	BST(){
		m_root = NULL;
		m_numNodes = 0;
	}
	~BST(){}
	// Get and set functions for BST
	Node* getRoot(){
		return m_root;
	}
	void setRoot(Node *newRoot){
		m_root = newRoot;
	}
	int getNumNodes(){
		return m_numNodes;
	}
	void incrementNumNodes(){
		m_numNodes++;
	}
	void decrementNumNodes(){
		m_numNodes--;
	}
	// Insert a new Node into the tree
	void insert_node(int value){
		//Node* newNode = new Node(value);
		Node* currNode = getRoot();
		if(currNode == NULL){
			setRoot(new Node(value));
			incrementNumNodes();
			return;
		}
		while(currNode != NULL){
			if(value == currNode->getValue()){
				printf("Duplicate node values in the tree. Not inserting new node.");
				return;
			}
			else if(value > currNode->getValue()){
				if(currNode->getrChild() != NULL)
					currNode = currNode->getrChild();
				else{
					currNode->setrChild(new Node(value));
					incrementNumNodes();
					return;
				} 
			}
			else{
				if(currNode->getlChild() != NULL)
					currNode = currNode->getlChild();
				else{
					currNode->setlChild(new Node(value));
					incrementNumNodes();
					return;
				} 
			}
				
		}
		return;
	}
	// Find a node in a BST
	bool find_node(int value){
		// No nodes in the tree
		if(getNumNodes() == 0){
			return false;
		}

		Node *currNode = getRoot();
		while(currNode != NULL){
			// Node found
			if(currNode->getValue() == value){
				return true;
			}
			else if(value > currNode->getValue()){
				currNode = currNode->getrChild();
			}
			else
				currNode = currNode->getlChild();
		}
		// Node not found
		return false;
	}
	// Delete a node in a BST
	bool delete_node(int value){
		// No nodes in the tree
		if(getNumNodes() == 0){
			return false;
		}

		Node *currNode = getRoot();
		Node *prevNode = currNode;
		while(currNode != NULL){
			// Target node is found
			if (currNode->getValue() == value){
				// Target node has no children
				if(currNode->getlChild() == NULL && currNode->getrChild() == NULL){
					currNode = NULL;	
					delete currNode;
				}
				// Target node has only a left subtree
				else if(currNode->getlChild() != NULL && currNode->getrChild() == NULL){
					// Find which child target node is of its parent
					// Current node is right child of its parent
					if(currNode->getValue() > prevNode->getValue()){
						prevNode->setrChild(currNode->getlChild());
						currNode = NULL;
						delete currNode;
					}
					// Current node is left child of its parent
					else{
						prevNode->setlChild(currNode->getlChild());
						currNode = NULL;
						delete currNode;
					}
				}
				// Target node  has only a right subtree
				else if(currNode->getlChild() == NULL && currNode->getrChild() != NULL){
					if(currNode->getValue() > prevNode->getValue()){
						prevNode->setrChild(currNode->getrChild());
						currNode = NULL;
						delete currNode;
					}
					// Current node is left child of its parent
					else{
						prevNode->setlChild(currNode->getrChild());
						currNode = NULL;
						delete currNode;
					}
				}
				// Target node has both a left and right subtree
				else{
					Node *targetNode = currNode;
					currNode = currNode->getlChild();
					// Node directly to the left of the target has no right subtree
					if(currNode->getrChild() == NULL){
						if(currNode->getValue() > prevNode->getValue()){
							prevNode->setrChild(currNode);
						}
						else{
							prevNode->setlChild(currNode);
						}
						currNode->setrChild(targetNode->getrChild());
						targetNode = NULL;
						delete targetNode;
					}
					// Node directly to the left of the target has a right subtree
					else{
						while(currNode->getrChild() != NULL){
							prevNode = currNode;
							currNode = currNode->getrChild();
						}
						if(currNode->getlChild() != NULL){
							prevNode->setrChild(currNode->getlChild());
						}
						targetNode->setValue(currNode->getValue());
						currNode = NULL;
						delete currNode;
					}
				}
				decrementNumNodes();
				return true;
			}
			// Target value is greater than the value of the current node
			else if(value > currNode->getValue()){
				prevNode = currNode;
				currNode = currNode->getrChild();
			}
			// Target value is less than the value of the current node
			else{
				prevNode = currNode;
				currNode = currNode->getlChild();
			}
		}
		// Target value was not found in the tree
		return false;
	}

	void traverse_inOrder(Node *currNode){
		if(currNode == NULL){
			printf("null ");
			return;
		}
		traverse_inOrder(currNode->getlChild());
		printf("%d ", currNode->getValue());
		traverse_inOrder(currNode->getrChild());
		return;
	}

	void traverse_preOrder(Node *currNode){
		if(currNode == NULL){
			printf("null ");
			return;
		}
		printf("%d ", currNode->getValue());
		traverse_preOrder(currNode->getlChild());
		traverse_preOrder(currNode->getrChild());
		return;
	}
};