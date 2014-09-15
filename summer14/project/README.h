//README

/* 	Author: Brandon Lundberg
	File Name:
	Purpose: Project details
	Date: 26 June 2014
*/

/*	To design this project, I want to begin by
	gathering the function requirements for the program. The program must:
		1. Identify a polynomial expression by evaluating individual elements of the expression.
		2. Identify the highest degree of the elements in a polynomial expression.
		3. Find the coeffecient of a particular element of the polynomial.
		4. Check two polynomials to see if they are identical.
		5. Sum two polynomials.
		6. Multiply two polynomials together. The new polynomial must be simplified to lowest terms.
 

		NOTE: The description of the program is not clear whether the polynomial will be in order of highest pair automatically, or if a function is neccessary to sort the polynomial accordingly.
*/

/*	How the program will run:

	1. Three polynomials will be manually entered into the program.
	2. A node will be used store the data of each element of the polynomial.
	3. A linked list will be used to connect each element of each polynomial.
	4. The program will run each neccessary function. Since the results from each function
	   do not depend on one another, the order of the functions is not important.
	5. End of program.
*/

/*
	Classes

	1. Node
		private members
			1. xCoef
			2. xDeg
			3. yDeg
			4. next
		public
			Get functions
			1. getxCoef
			2. getxDeg
			3. getyDeg
			4. getNext
			Set functions
			1. setxAddCoef
			2. setxDotCoef
			3. setxDeg
			4. setyDeg
			1. setNext
	2. SLL
		private members
			1. first
			2. last
			3. nodeCount
		public members
			Get Functions
			1. getFirst
			2. getLast
			3. getCount
			Set Functions
			1. setFirst
			2. setLast
			3. setCount
			Necessary Functions
			1. degree()
			2. coefficient()
			3. match()
			4. dot()
			5. sum()
			6. dot()
			Helper Functions
			1. incrementCount
			2. decrementCount
			3. createNode
			4. enterInfo
			5. printSLL
			6. simplify
			7. replaceContents
*/

/*	Function Descriptions:
	The get and set functions in the Node and SLL class are very straight forward,
	so no explanation should be needed for those.

	However, the SLL class has a few functions that are a little more in depth.
*/
/*
	The enterInfo function is in place to prompt the user to input all neccessary information of each node of the 3 polynomials.
	The function is called for each polynomial created in main().
*/
/*
	The degree function simply traverses through a polynomial and finds the element that
	has the highest value when adding the x degree and the y degree together. If two
	elements have the same degree, they both have the highest degree, but the return
	value is from the first highest element
*/
/*
	The coefficient function traverses to the element number passed into function and 
	returns that elements x coefficient
*/
/*
	The match function checks to see if two polynomials are identical. A Node pointer is set at
	the beginning of each polynomial. These pointers traverse through the polynomial to check the values
	of each node. If a node is not identical, or the lists are not the same length, the function will return
	a false value. Otherwise, the polynomials are identical and the function will return true.
*/
/*
	In order to use the sum and dot functions, I implemented the simplify and replaceContents functions
	to modify a polynomial. 
	
	Simplify finds any elements in a polynomial with the same x and y degree, then
	modifies the first element with those parameters and deletes the now duplicate element. This function
	only deletes one node at a time, so the function is run once for every element in the polynomial.
	
	replaceContents takes in a SLL pointer as a parameter and replaces whatever is in the polynomial that
	called the function. I found this helpful in the sum and dot functions because while trying to just update
	the current polynomial during computation, the polynomials were updated while I still neede the information
	prior to that update. Instead, I created a new polynomial, placed the contents of each computation in 
	the new polynomial, then called the replaceContents function with the polynomial that I began with. This
	approach was much cleaner and easier to implement.
*/

/*
	The sum function added the contents of both polynomials to the new polynomial I talked about
	in the last section. Then, the simplify and replaceContents functions were called to modify the
	origianl polynomial that called the function.
*/
/*
	The dot function has two pointers with each pointing to the first element of the two polynomials.
	The pointers are traversed through both polynomials in a nested while loop so each element is multiplied
	together. After each multiplication, a node with the new parameters was added to a new polynomial. After all
	the multiplications, the simplify and replaceContents functions are called to modify the polynomial that called
	the function.
*/

/* When the program runs it will look something like this:
Enter the information for the 1st element of the number 1 polynomial
with spaces in between
(x coefficient x degree y degree): 5 4 2
Enter another element?(enter 0 to quit or 1 to continue): 1
Next element: -6 3 0
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: 2 2 1
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: -7 1 0
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: 6 0 0
Enter another element? (enter 0 to quit or 1 to continue): 0
Enter the information for the 1st element of the number 2 polynomial
with spaces in between
(x coefficient x degree y degree): 5 4 2
Enter another element?(enter 0 to quit or 1 to continue): 1
Next element: -6 3 0 
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: 2 2 1
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: -7 1 0
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: 6 0 0
Enter another element? (enter 0 to quit or 1 to continue): 0
Enter the information for the 1st element of the number 3 polynomial
with spaces in between
(x coefficient x degree y degree): 3 2 1
Enter another element?(enter 0 to quit or 1 to continue): 1
Next element: 4 1 2
Enter another element? (enter 0 to quit or 1 to continue): 1
Next element: 7 0 0
Enter another element? (enter 0 to quit or 1 to continue): 0
Polynomial 1
Element 1: 5 4 2
Element 2: -6 3 0
Element 3: 2 2 1
Element 4: -7 1 0
Element 5: 6 0 0
Polynomial 2
Element 1: 5 4 2
Element 2: -6 3 0
Element 3: 2 2 1
Element 4: -7 1 0
Element 5: 6 0 0
Polynomial 3
Element 1: 3 2 1
Element 2: 4 1 2
Element 3: 7 0 0
Polynomial 1 highest degree: 6
polynomial 2 highest degree: 6
polynomial 3 highest degree: 3
X Coefficient 3 of polynomail 1: 2
X Coefficient 2 of polynomail 2: -6
X Coefficient 1 of polynomail 3: 3
Polynomial 1 match Polynomial 2?: True
Polynomial 1 match Polynomial 3?: False
After sum function--
Polynomial 1
Element 1: 5 4 2
Element 2: -6 3 0
Element 3: 5 2 1
Element 4: 4 1 2
Element 5: -7 1 0
Element 6: 13 0 0
After dot function--
Polynomial 2
Element 1: 15 6 3
Element 2: 20 5 4
Element 3: -18 5 1
Element 4: 17 4 2
Element 5: 8 3 3
Element 6: -21 3 1
Element 7: -42 3 0
Element 8: -28 2 2
Element 9: 32 2 1
Element 10: 24 1 2
Element 11: -49 1 0
Element 12: 42 0 0
