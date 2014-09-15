class Node{
private:
	Node *m_parent;
	Node *m_lChild;
	Node *m_rChild;
	char m_letter;
public:
	Node(char letter = '\0', Node *parent = NULL, Node *lChild = NULL, Node *rChild = NULL){
		m_parent = parent;
		m_lChild = lChild;
		m_rChild = rChild;
		m_letter = letter;
	}
	~Node(){}
	// get functions
	Node* getParent(){return m_parent;}
	Node* getlChild(){return m_lChild;}
	Node* getrChild(){return m_rChild;}
	char getLetter(){return m_letter;}
	// set functions
	void setParent(Node *parent){m_parent = parent;}
	void setlChild(Node *lChild){m_lChild = lChild;}
	void setrChild(Node *rChild){m_rChild = rChild;}
	void setLetter(char letter){m_letter = letter;}
};