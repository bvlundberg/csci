#include <iostream>
using namespace std;

class Node{
	public: 
		Node *next;
		int value;

		Node(int num){
			value = num;
		}
};

class CLinkedList{
public:
	Node *head;
	int count;
	CLinkedList(){
//		head->next = NULL;
		count = 0;
	}

	~CLinkedList(){
		Node *p = head->next;
		while(count != 0){
			head->next = p->next;
			delete p;
			count--;
		}
	}

	void enqueue(int value){
		if(count == 0){
			Node *p = new Node(value);
			p->next = head;
			head->next = p;
			count++;
		}
		else{
			Node *p = new Node(value);
			p->next = head->next;
			head->next = p;
			count++;
		}
	}

	int dequeue(){
		Node *p = head->next;
		while(p->next->next != head){
			p = p->next;
		}
		int temp = p->next->value;
		delete p->next;
		count--;
		p->next = head;
		return temp;
	}

};

int main(){
	CLinkedList queue;

	queue.enqueue(9);
	queue.enqueue(3);
	queue.enqueue(6);
	queue.enqueue(1);
	queue.enqueue(4);

	int x = queue.dequeue();
	cout << x << endl;
	x = queue.dequeue();
	cout << x << endl;
	x = queue.dequeue();
	cout << x << endl;
	x = queue.dequeue();
	cout << x << endl;
	x = queue.dequeue();
	cout << x << endl;

	queue.enqueue(10);
	queue.enqueue(7);

	x = queue.dequeue();
	cout << x << endl;
	return 0;
}

