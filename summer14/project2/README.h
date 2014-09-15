// README

/* 	Author: Brandon Lundberg
	File name:
	Purpose: Project details
	Date: 11 July 2014
*/

/* The first set of instructions for the program is to create a queue that is organized
   in accordance to how long each task takes to execute. My plan to create such a list is
   to sort the tasks before they are dequeued. The 2 dequeue sort functions will sort using
   their unique algorithms. The sorting will not be done everytime a new
   element is added to the list, but only when dequeuing is necessary. Then, the dequeue
   function will be called to delete the top node.
*/

/* The PQ class will have the following members and fucntions:
	Members
	1. A DLL that will represent the queue.
	2. A bool variable that determines whether an task is executing or not.
	3. An int variable that holds the time that a dequeued node is running in the CPU
	4. An int variable that holds the amount of executions run by the CPU.
	Functions
	1. Enqueue function that will add a task to the front of the DLL
	2. Dequeue function using shell sort from DLL class to sort the DLL.
	3. Dequeue function using quick sort from DLL class to sort the DLL.
	4. Dequeue function to call delete function in DLL class.
	5. Get and set functions for the bool and int variables.
	6. Start and run functions to begin the CPU usage and end the CPU usage.
	7.. Print function to show the current queue.
*/
	
/*	The DLL class will have the following members and fucntions:
	Members
	1. Node elements to hold the first and last element of the DLL.
	2. An integer to hold the size of the DLL.
	Functions
	1. Get and set functions to access the DLL members.
	2. A function to create a task and enter it to the front of the DLL.
	3. Delete function to delete the first element of the DLL.
	4. Quick Sort and Shell Sort, with their neccessary helper functions.
	5. Jump functions to move a node a certain number of elements.
	6. Less than that compares the execution of two nodes.
	7. Swap function that changes the data of two nodes.
	8. Print function to print the elements of a DLL.


*/

/*	The Node class is very simple, containing the 3 elements neccessary for 
	the function: ID, Entering Time, Execution Time. The class also has the functions 
	neccessary to access and initialize those members.

/*	The plan of how the program will run.
	1. Create a DLL of nodes that have every task from the imput file.
	2. A while loop in the main function that will act as the timer for the program.
	   As this loop runs, each task from the DLL will be added to the queue and run according
	   to priority and the bool that checks if anything is in the processor. The while loop
	   will end once all the elements from the created DLL have finished executing.
*/