class Node{
	private:
		int m_xCoef;	// x coefficient of the element
		int m_xDeg;		// x degree of the element
		int m_yDeg;		// y degree of the element
		Node *m_next;	// pointer connecting elements
	public:
		Node(int xCoef = 0, int xDeg = 0, int yDeg = 0, Node *next = NULL)/* bool sign)*/{
			m_xCoef = xCoef;	
			m_xDeg = xDeg;		
			m_yDeg = yDeg;		
			m_next = next;		
		}

		~Node(){}
		// Get functions
		int getxCoef(){return m_xCoef;}
		int getxDeg(){return m_xDeg;}
		int getyDeg(){return m_yDeg;}
		Node* getNext(){return m_next;}
		// Set functions
		void setxAddCoef(int xCoef, int xAddcoef){m_xCoef = xCoef + xAddcoef;}	// This function changes the x coefficient by adding
		void setxDotCoef(int xCoef, int xDotCoef){m_xCoef = xCoef * xDotCoef;}	// This function changes the x coefficient by multiplying
		void setxDeg(int xDeg, int xDotDeg){m_xDeg = xDeg + xDotDeg;}
		void setyDeg(int yDeg, int yDotDeg){m_yDeg = yDeg + yDotDeg;}
		void setNext(Node* next){m_next = next;}

};