/* 	Author: Brandon Lundberg
	File Name: README.h
	Purpose: Layout of lab and files attached
	Date: 26 Jan 2015
*/

/*	Neccesary files:
		Graph.h - Implementation of the node class
			Members:
				Pointers to prev node, next node and head of list
				Integer holding the value of the vertex connected to the current vertex
			Methods:
				initialize graph - takes in the initial number of verticies and the initial number of edges, creates a new directed graph, instantiated adjacency lists and the initial edges inserted
					1. Set pointers in the adjacency list to null values for each vertex
					2. For each defined edge
						a. prompt user to enter the directed path for the edge (from vertex A to vertex B)
						b. Call insert with these verticies as input
			    insert edge - inserts a directed edge (V1 - > V2) into the graph
			    	1. Retrieve the parent vertex from the first parameter
			    	2. If the list is empty
			    		a. create graph pointer for the new vertex with the following parameters
			    			1. prev = null
			    			2. next = null
			    			3. value = second parameter to the insert function
			    			4. head = itself
			    	3. If the vertex is not already in the list, add the child vertex to the adjacency list for that parent vertex
			    		a. Find end of list
			    		b. If the value has not been found, create graph pointer for it with the following parameters
			    			1. prev = last graph pointer in the list
			    			2. next = null
			    			3. value = second parament to the insert function
			    			4. head = first graph pointer in the list
			    		c. Other connection
			    			1. Second to last value next = new pointer
			    delete edge - deletes an edge (V1 -> V2) from the graph
			    list all edges - lists all of the edges in the graph
			    list all neighbors - lists all of the neighbors for a particular vertex, does not have to be adjacent
			    no incoming edges - lists all of the vertices with no incoming edges
		adj_list.cpp - Implementation of the adjacency lists
		adj_matrix.cpp - Implementation of the adjacency matrix
*/
