// ReadMe.h

/*	Author: Brandon Lundberg
	File Name: README.h
	Purpose: Project Details
	Date: 24 July 2014
*/

/*	The neccessary classes for the assignment include a tree, heap and node classes.
	
	The Node class is in place to hold the information concerning a nodes' children and parent.
	The Tree class is in place to make the neccessary connections between inserted nodes.
	The Heap class will access a tree and will run operations on that tree.

// 	Node class:

	This class will have the following private member functions:
	1. Node *parent
	2. Node *lChild
	3. Node *rChild
	4. char letter
	
	The public functions concerning this class will be basic get and set functions to
	access the Nodes' information.

// 	Tree class:
	
	This class will have the following private member functions:
	1. Node *root
	2. int Size (which is the number of nodes in the tree)

	
	The public functions concerning this class will be basic get and set functions to 
	access the Nodes' information, as well as the functions neccessary to build the heap. 
	1.	create Node (this function will ensure that a new Node will still be a complete tree)
		If the heap is empty, set the root to this node
		In any other instance, call findAddNode function, which uses the size of the heap to find
		the correct position to insert the node. findAddNode uses the properties of a tree, so that
		each child is x2 and x2 + 1 of the parent.
	2.	deleteNode calls findDeleteNode, which searches for the node at the position that is equal
		to the size of the heap. findDeleteNode swaps the data from the root and last node, then 
		deletes the last node, which now has the max value of the heap. The function then sinks the 
		new top element to its proper position in the heap.
	3.	The correctStructure and correctValues functions are in place to check to see if the tree is a
		heap or not. Both functions are bool returns and if they are both satisfied, the isHeap function
		in the Heap class returns a true as well. These functions make sure that:
			1. a NULL node is a heap
			2. all children are less in value than their parent
			3. any level is filled before it moves on to the next level.
			4. if a level is not filled, it is at least leftmost filled
	4.	findSearchNode is used in the lookup function in the Heap class. It is in place to search for
		a node with a desired value. Instead of a bool return, there is an integer pointer containing a
		0 or 1 to simulate a bool return. This integer is an alias from a reference that begins as a 0
	5. 	findLengthNode is used by the length function in the Heap class. This function finds and returns
		a node with a desired letter.
	6.	sink, swim, and swap functions are self explanitory
//	Heap class:

	This class will have the following private member functions:
	1. Tree *tree1

	The public functions will be much more complex than the two previous classes.
	1. 	insertNode function to add a Node to the tree. This function calls createNode from the Tree class.
	2.	removeNode function to delete a Node from the tree (must be maximum char from tree). This function
		calls deleteNode from Tree class.
	3.	lookup function uses the findSearchNode to see if a letter is in the heap and prints the result
		of the search
	4.	isHeap calls correctValues and correctStructure to check if the heap properties have been met and
		print the result.
	5.	length calls the findLengthNode function to find two nodes. Then, it traverses through the heap to 
		see if these nodes are ancestors of each other. If they are, it prints the result. Otherwise, it prints
		an error of why the length was not calculated.
	6.	sibling uses the length function to check the distance from a node and the root. If the nodes are the
		same distance from the root, then the nodes are siblings. Otherwise, they are not.

	NOTES:
	1. Assume no duplicates in the heap
	2. For the length function, assume the first letter as a parameter is further down the heap than the second
	   parameter so the function can traverse correctly.

	For my project, the heap for the input "Brando" will be a maximum heap, which will be inserted
	like this as it heapifies

			       r

			   n       o

			b     d a

	As for the printing to the screen, I showed information relevant to different traverses to show
	where a node is being added to the heap, the current size of the heap, where elements are swapping
	with each other and what elements are being searched/compared to so it is easier to read what is occuring
	in each function.