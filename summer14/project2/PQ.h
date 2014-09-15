#include "DLL.h"
class PQ{
private:
	DLL *doublelist;
	int m_executionTime;
	bool executing;
	int m_executions;
public:
	// Constructor
	PQ(){
		doublelist = new DLL();
		executing = true;
		m_executions = 0;
	}
	// Destructor
	~PQ(){

	}
	// Get functions
	Node* getFirstPQ(){return doublelist->getFirst();}
	int getTopID(){return doublelist->getFirstID();}
	int getSize(){return doublelist->getSize();}
	int getExecutionTime(){return m_executionTime;}
	bool getExecutingStatus(){return executing;}
	int getNumberExecutions(){return m_executions;}
	// Set functions
	void setExecutionTime(int executionTime){m_executionTime = executionTime;}
	void decrementExecutionTime(){m_executionTime--;}
	void setExecutingStatus(bool key){executing = key;}
	void incrementNumberExecutions(){m_executions++;}
	// Other Functions
	void enqueue(Node *newNode){
		doublelist->createNode(newNode->getID(),newNode->getEnteringTime(),newNode->getExecutionTime());
	}
	// The return value in both dequeue functions will be their execution time
	int dequeueShellSort(){
		doublelist->shellSort();
		return getFirstPQ()->getExecutionTime();
	}
	int dequeueQuickSort(){
		doublelist->quickStart();
		return getFirstPQ()->getExecutionTime();
	}
	void dequeue(){
		doublelist->deleteFirst();
	}
	void startTimer(int executionTime){
		setExecutionTime(executionTime);
		setExecutingStatus(false);
	}
	void runTimer(){
		decrementExecutionTime();
		if(getExecutionTime() == 0){
			incrementNumberExecutions();
			setExecutingStatus(true);
		}
	}
	void printPQ(){
		doublelist->printDLL();
	}
};