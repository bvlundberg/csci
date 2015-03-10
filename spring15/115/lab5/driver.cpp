/*	Author:		Brandon Lundberg
	File Name:	driver.cpp
	Purpose: Runs the test cases for the linked list implementation
	Date: 2 March 2015
*/

/*	Rules
	1. Error messages in the case of bad input
	 variable expected (i.e., the input “9ab” would trigger this error message)
	 '=' expected (i.e., the input “a9b” would trigger this error message)
	 variable or number expected (i.e., the input “a=+b” would trigger this error message”)
	 operator expected (i.e., the input” a=123 456 + 12” would trigger this error message”)
	 integer expected (i.e., the input a=2^b” would trigger this error message”)
	 end of line expected (i.e., the input “a=123+456 b” would trigger this error message)

	2. Output is value assigned to the variable, and then
	 (active, free) as in
	 123412341234 (4,7)
	3. Variables are single lowercase letters
	4. Subtraction is truncated, meaning that if a < b, then
	 a - b is 0.
	5. Lists should be freed when they are not accessible;
	 i.e., when a variable is overwritten or when a number
	 constant is no longer needed, as in y = 1234 + x
	6. Exponentiation should be implemented using the method
	 of repeated squaring

*/
#include <cstdlib>      /* printf, NULL */
#include <string>
#include <stdio.h>
#include <ctype.h>
#include <iostream>
using namespace std;

#include "lists.cpp"
#include "calculator.h"
#include "calculator.cpp"
	template <typename E> int 		Link<E>::activeNodes = -2;
	template <typename E> int 		Link<E>::freeNodes = 0;
	template <typename E> Link<E>* 	Link<E>::freeList = NULL;



int main(){
	Calculator c1;
	Link<int>* d1 = c1.a.getHead(); 
	Link<int>* s1 = c1.temp1.getHead();
	Link<int>* s2 = c1.temp2.getHead();

	bool validate;
	string inputString;
	string destination;
	string source1;
	string source2;
	string op;

	while(1){
		// Reset input values
		inputString = "";
		destination = "";
		source1 = "";
		source2 = "";
		op = "";
		// Get user input
		cout << "Input string: ";
		getline(cin, inputString);
		// Validate string
		validate = c1.parseString(inputString, &destination, &source1, &source2, &op);
		// Find integer values or register for first source value
		s1 = c1.identifySource(source1, 1);
		// Find integer values or register for second source value
		s2 = c1.identifySource(source2, 2);
		// Find destination register
		d1 = c1.identifyDestination(destination);
			
		
		
		// Print values to be calculated
		c1.calculate(d1, s1, s2, op);
		c1.printList(d1);
		c1.printList(s1);
		cout << "operator: " << op << endl;
		c1.printList(s2);
	}
	return 0;
}