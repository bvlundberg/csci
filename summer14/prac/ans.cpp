#include <iostream>
#include <fstream>
#include <stack>
#include <string>
#include <stdlib.h>
using namespace std;
class Node
{
public:
    Node(){}
    Node(int value=0, Node* next= NULL, Node* prev= NULL) { this->value = value; this->next = next; this->prev = prev;}
    Node* next;
    Node* prev;
    int value;
};

class CLL //circular linked list based on textbook concept
{
public:
    CLL()
    {
        head = new Node(0,NULL,NULL); //head does not count. it is "watch surface"
        head->next = head;
        head->prev = head;
        size =0;
    }
    void push_front(int v)
    {
        Node* nn = new Node(v,NULL);
        if (head->next==head)
        {
            head->next = nn;
            head->prev = nn;
        }
        else
        {
            nn->next = head->next;
            head->next = nn;
        }
        size++;
    }
    void push_back(int v)
    {
        Node* nn = new Node(v, NULL,NULL);
        if (head->prev==head)
        {
            head->prev = nn;
            head->next = nn;
        }
        else{
            head->prev->next = nn; //order matters
            head->prev = nn;
            
        }
        size++;
    }
    
    int pop_front()
    {
        int v =-1;
        Node* f = head->next;
        if (f != head)
        {
            v = f->value;
            head->next = f->next;
            delete f;
            size--;
            return v;
        }
        return -1;
        
    }
    
    int pop_back()
    {   int v =-1;
        Node* b = head->prev;
        if (b != head)
        {
            v = b->value;
            head->prev = b->prev;
            delete b;
            size--;
            return v;
        }
        return v;
    }
    
    void print()
    {
        Node* p = head->next;
        
        while (p!= head)
        {
            cout<<p->value<<endl;
            p = p->next;
        }
        cout<<""<<endl;
    }
private:
    Node* head;
    int size;
};

class Queue
{
public:
    Queue() { l = new CLL(); size = 0; }
    ~Queue() { delete l; }
    void push(int v)
    {
        l->push_back(v);
    }
    int pop()
    {
        int v = l->pop_back();
        return v;
    }
    void print()
    {
        l->print();
    }
    
private:
    CLL* l;
    int size;
};

void problem_1_3_9()
{
	string str;
	stack<string> ops;
	stack<string> result;
	cout<<"please cin the expression"<<endl;
	string exp="(";
	cin>>str;
	int i =0;
	while (i < str.length())
	{
		if (str[i] == '+' || str[i] =='-' || str[i] =='*' || str[i] == '/')
			ops.push(string(1,str[i]));
		if (isdigit(str[i]))
			result.push(string(1,str[i]));
		if (str[i] == ')'){
			string right = result.top(); //convert from char to string
			result.pop();
			string left= result.top();
			result.pop();
			string op = ops.top();
			ops.pop();
			exp=exp+left+op+right+")";
			result.push(exp);
			exp="(";
		}
		i++;
	}
	exp=result.top();
	cout<<exp<<endl;
	
	
}


int problem_1_3_11(){
    string str;
    stack<char> ops;
	//stack<string> result;
	cout<<"please cin the postfix"<<endl;
	cin>>str;
	int i =0;
	while (i < str.length())
	{
        if (isdigit(str[i]))
            ops.push(str[i]);//string(1,str[i]));

		else if (str[i] == '+' || str[i] =='-' || str[i] =='*' || str[i] == '/'){
			char right= ops.top();
            ops.pop();
            char left = ops.top();
            ops.pop();
            int rightint = right - '0';
            int leftint = left - '0';
            char x=' ';
            //bug below if result becomes two or more digits.
            //bugs can be removed by using string and a function converts from string to int
            if (str[i] =='+'){
                x = char((leftint+rightint)+'0');
                ops.push(x);
            }
            else if (str[i] =='-'){
                x = char((leftint-rightint)+'0');
                ops.push(x);
            }
            else if (str[i] =='*'){
                x = char((leftint*rightint)+'0');
                ops.push(x);
                
            }
            else if (str[i] =='/'){
                x = char((leftint/rightint)+'0');
                ops.push(x);
            }

        }
    
		i++;
	}
    char result = ops.top();
    ops.pop();
    return result - '0';
    
}

void problem_1_3_29()
{
    Queue q;
    q.push(1);
    q.push(2);
    q.pop();
    q.print();
}

int main (int argc, char * const argv[]) {
	// insert code here...
	std::cout << "Hello, World!\n";
    //cout << problem_1_3_9()<<endl;
	cout<<problem_1_3_11()<<endl;
	problem_1_3_29();
    return 0;
}
