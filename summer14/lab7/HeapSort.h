#include "PQ.h"
class HeapSort{
private:
	PQ *m_queue;
public:
	HeapSort(PQ *queue){
		m_queue = queue;
	}
	void heapify(){
		for(int i = m_queue->getSize() / 2; i >= 1; i--){
			cout << m_queue->getSize();
			m_queue->sink(i);
			m_queue->printPQ();
		}
	}
	void sortDown(){
		for(int i = 1; i <= m_queue->getSize(); i++){
			m_queue->deleteMax();
		}
	}
	void printHeap(){
		m_queue->printPQ();
	}
};