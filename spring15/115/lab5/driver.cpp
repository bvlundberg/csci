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
#include <stdio.h>
#include <ctype.h>
#include <iostream>
using namespace std;

#include "lists.cpp"
	template <typename E> int 		Link<E>::activeNodes = -2;
	template <typename E> int 		Link<E>::freeNodes = 0;
	template <typename E> Link<E>* 	Link<E>::freeList = NULL;

void parseString(string input){
	int size = input.length();
	int i = 0;
	// Read first character
	if(!islower(input[0])){
		cout << "variable expected" << endl;
		return;
	}
	i++;
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read "="
	if(input[i] != '='){
		cout << "= expected" << endl;
		return;
	}
	i++;
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read variable or number
	while(1){
		if(islower(input[i])){
			i++;
			break;
		}
		else if(isdigit(input[i])){
			i++;
			while(isdigit(input[i])){
				i++;
			}
			break;
		}
		else{
			cout << "variable or number expected" << endl;
			return;
		}
	}
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read operator
	switch(input[i]){
		case '+': case '-' : case '*' : case '^': 
			break;
		default : 
			cout << "operator expected" << endl;
			return;
	}
	// Branch on this case
	if(input[i] == '^'){
		i++;
		// Check for whitespace
		while(isspace(input[i])){
			i++;
		}
		// Check for integer
		if(!isdigit(input[i])){
			cout << "integer expected" << endl;
			return;
		}
		// Read integer
		while(isdigit(input[i])){
			i++;
		}
		// Check for end of line
		if(i < size){
			cout << "end of line expected" << endl;
			return;
		}
		return;
	}
	else{
		i++;
		// Check for whitespace
		while(isspace(input[i])){
			i++;
		}
		// Read variable or number
		while(1){
			if(islower(input[i])){
				i++;
				break;
			}
			else if(isdigit(input[i])){
				i++;
				while(isdigit(input[i])){
					i++;
				}
				break;
			}
			else{
				cout << "variable or number expected" << endl;
				return;
			}
		}
		// Check for end of line
		if(i < size){
			cout << "end of line expected" << endl;
			return;
		}
	}
}

int main(){
	//Link<E>* Link<E>::freelist = NULL;
	LinkedList<int> l;
	string inputString = "";
	while(1){
		cout << "Input string: ";
		getline(cin, inputString);
		parseString(inputString);
	}

	/*
	// Error message 1 -- Variable expected
	string inputString = "9ab";
	parseString(inputString);

	// Error message 2 -- = expected
	inputString =  "a9b";
	parseString(inputString);


	// Error message 3 -- Variable or number expected
	inputString = "a=+b";
	parseString(inputString);

	// Error message 4 -- operator expected
	inputString = "a=123 456 + 12";
	parseString(inputString);
	
	// Error message 5 -- integer expected
	inputString = "a=2^b";
	parseString(inputString);

	// Error message 6 -- end of line expected
	inputString = "a=123+456 b";
	parseString(inputString);
	*/
	return 0;
}
