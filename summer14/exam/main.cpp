/* Author: Brandon Lundberg
   File name: main.cpp
   Purpose: Programming Exam
   Date: 24 July 2014
*/

/*
 CSCI 41 Summer 2014, Programming Exam 9:30am.
 Note, please do not discuss this exam with anyone after test. Violators will be considered as honor code violation, 
 and will be reported to the University directly.
 
 EXAM REQUIREMENTS:
 
 During lectures, we covered 4 different implementations for coding priority queue. The first one is based on sorting (it is also the worst one. Please find MERGE sort animation in the PDF.) The second one is based on HEAP (please find sink and swim animation in the PDF).
 
 PLease introduce a To-Do list project using priority queue along with ordered array and HEAP (two implementations). The project will request to input/insert items (insert function in the main function) to be done. Each item has its description and priority (assume priority is never duplicate). At some point, current highest priority item in the to-do list will be removed (i.e., action function in the main function below).
 
 Please refer to the PDF
 
 1. Item class has description (string type) and priority (int type). You don't need to do anything here.
 2. Introduce a ToDo class using Prioritey Queue concept along with merge sort.
    a. Introduce "action" function. This function will return the highest priority item and then delete it. The item of the highest priority will be returned by "action" function.
 
 3. Introduce a ToDo class using HEAP based Prioritey Queue
    a. Introduce "action" (namely, dequeue) function. This function will delete the highest priority item. The highest priority item will be returned by "action" function.
    b. Introduce "sink" and "swim" functions.
 */


#include <iostream>
#include "ToDo.h"
#include "ToDo2.h"
using namespace std;
int main (int argc, char * const argv[]) {
 
	//the higher number, the higher priority
    //merge sort based
    cout << "Merge based approach: " << endl;
	ToDo* todo = new ToDo(10);
	todo->insert("wash car", 2);
	todo->insert("turn in Csci 41 homework", 5);
	todo->insert("watch Life of Pi", 1);
	cout<<todo->action().getDescription()<<endl; //action function is the same as dequeue
	todo->insert("study csci 60", 4);
	cout<<todo->action().getDescription()<<endl;
	todo->insert("date with xxx", 3);
	cout<<todo->action().getDescription()<<endl;
    cout << endl;
    //the higher number, the higher priority
    //HEAP based
    cout << "Heap Based Approach: " << endl;
    ToDo2* todo2 = new ToDo2(10);
	todo2->insert("wash car", 2);
	todo2->insert("turn in Csci 41 homework", 5);
	todo2->insert("watch Life of Pi", 1);
	cout<<todo2->action().getDescription()<<endl;
	todo2->insert("study csci 60", 4);
	cout<<todo2->action().getDescription()<<endl;
	todo2->insert("date with xxx", 3);
	cout<<todo2->action().getDescription()<<endl;
	

    return 0;
	
	
}
