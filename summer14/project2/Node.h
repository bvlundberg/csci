class Node{
	private:
		int m_id;	// x coefficient of the element
		int m_entering;		// x degree of the element
		int m_execution;		// y degree of the element
		Node *m_next;	// pointer connecting elements
		Node *m_prev;
	public:
		Node(int id = 0, int entering = 0, int execution = 0, Node *next = NULL, Node *prev = NULL){
			m_id = id;	
			m_entering = entering;		
			m_execution = execution;		
			m_next = next;
			m_prev = prev;		
		}

		~Node(){}
		// Get functions
		int getID(){return m_id;}
		int getEnteringTime(){return m_entering;}
		int getExecutionTime(){return m_execution;}
		Node* getNext(){return m_next;}
		Node* getPrev(){return m_prev;}
		// Set functions
		void setID(int id){m_id = id;}
		void setEnteringTime(int entering){m_entering = entering;}
		void setExecutionTime(int execution){m_execution = execution;}
		void setNext(Node* next){m_next = next;}
		void setPrev(Node* prev){m_prev = prev;}
};