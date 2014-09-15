/* 	Author: Brandon Lundberg
	File name: main.cpp
	Purpose: Main Function
	Date: 11 July 2014
*/

#include <iostream>
#include <fstream>
	using namespace std;
#include "PQ.h"

int main(){
	int timer = 0;								// Runtime of the function
	DLL *taskList1 = new DLL();					// Holds data to be used during execution
	
	// File declarations
	ifstream infile ("data1");
	ofstream outfile("output");
	outfile << "Data being executed for List 1: " << endl;
	
	// Read data from file and create a DLL with this information

	for(int count = 0; count < 10; count++){
		int id, entering, execution;
		infile >> id >> entering >> execution;
		taskList1->createNode(id,entering,execution);
		outfile << id << " " << entering << " " << execution << endl;
	}
	outfile << endl;
	infile.close();		// Close input file

	int constantListSize = taskList1->getSize();					// Holds the initial size of the input list
	int idExecuting = 0, executionExecuting = 0, holdTimer = 0;		// Data members used to print departure ID and time
	// Begin Quick Sort Method
	PQ *priorityQueue1 = new PQ();
	outfile << "Quick Sort Method" << endl;
	Node *p = taskList1->getFirst();
	while(priorityQueue1->getNumberExecutions() < constantListSize-1){
		outfile << "Timer: "<< timer << " "<< endl;
		// Check if node should be added to the priority queue
		while(p->getEnteringTime() == timer){
			priorityQueue1->enqueue(p);
			outfile << "Entering: " << p->getID() <<" "<< p->getEnteringTime() <<" "<< p->getExecutionTime()<<" "<< endl;
			if(p->getNext() != NULL)
				p = p->getNext();// Check if node should be added to the priority queue
			else break;
		}
		// Run execution if CPU is in progress
		if(!priorityQueue1->getExecutingStatus())
			priorityQueue1->runTimer();
		// Printing departure time of a node
		if(priorityQueue1->getExecutingStatus() && priorityQueue1->getNumberExecutions() > 0){
				outfile << "Departure: "<< idExecuting << " " << executionExecuting << " " << endl;
			}
		// Dequeue and execute a node if CPU is available
		if(priorityQueue1->getExecutingStatus()){
			if(priorityQueue1->getFirstPQ() != 0){
				int newExecutionTime = priorityQueue1->dequeueQuickSort();
				outfile << "Executing: "<< priorityQueue1->getFirstPQ()->getID() <<" "<< timer <<endl;
				// Hold information for departure time
				holdTimer = timer;
				idExecuting = (priorityQueue1->getFirstPQ())->getID();
				executionExecuting = timer + priorityQueue1->getFirstPQ()->getExecutionTime();
				// Dequeue node and start execution timer
				priorityQueue1->dequeue();
				priorityQueue1->startTimer(newExecutionTime);
			}
		}
		timer++;
	}
	// Begin Shell Sort Method
	PQ *priorityQueue2 = new PQ();
	outfile << endl << "Shell Sort Method" << endl;
	// Reset CPU information
	idExecuting = 0;
	executionExecuting = 0;
	holdTimer = 0;
	timer = 0;
	p = taskList1->getFirst();

	while(priorityQueue2->getNumberExecutions() < constantListSize-1){
		outfile << "Timer: "<< timer << " "<< endl;
		// Check if node should be added to the priority queue
		while(p->getEnteringTime() == timer){
			priorityQueue2->enqueue(p);
			outfile << "Entering: " << p->getID() <<" "<< p->getEnteringTime() <<" "<< p->getExecutionTime()<<" "<< endl;
			if(p->getNext() != NULL)
				p = p->getNext();
			else break;
		}
		// Run execution if CPU is in progress
		if(!priorityQueue2->getExecutingStatus())
			priorityQueue2->runTimer();
		// Printing departure time of a node
		if(priorityQueue2->getExecutingStatus() && priorityQueue2->getNumberExecutions() > 0){
				outfile << "Departure: "<< idExecuting << " " << executionExecuting << " " << endl;
			}
		// Dequeue and execute a node if CPU is available
		if(priorityQueue2->getExecutingStatus()){
			if(priorityQueue2->getFirstPQ() != 0){
				int newExecutionTime = priorityQueue2->dequeueQuickSort();
				outfile << "Executing: "<< priorityQueue2->getFirstPQ()->getID() <<" "<< timer <<" "<<endl;
				// Hold information for departure time// Hold information for departure time
				holdTimer = timer;
				idExecuting = priorityQueue2->getFirstPQ()->getID();
				executionExecuting = timer + priorityQueue2->getFirstPQ()->getExecutionTime();
				// Dequeue node and start execution timer
				priorityQueue2->dequeue();
				priorityQueue2->startTimer(newExecutionTime);
			}
		}
		timer++;
	}
	outfile.close();
	return 0;
}