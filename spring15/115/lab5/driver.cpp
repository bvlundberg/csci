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
	template <typename E> int 		Link<E>::activeNodes = -2;
	template <typename E> int 		Link<E>::freeNodes = 0;
	template <typename E> Link<E>* 	Link<E>::freeList = NULL;

bool parseString(string input, string *destination, string *source1, string *source2, string *op){
	int size = input.length();
	int i = 0;
	// Read first character
	if(!islower(input[0])){
		cout << "variable expected" << endl;
		return false;
	}
	*destination = input[0];
	i++;
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read "="
	if(input[i] != '='){
		cout << "= expected" << endl;
		return false;
	}
	i++;
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read variable or number
	while(1){
		if(islower(input[i])){
			*source1 = input[i];
			i++;
			break;
		}
		else if(isdigit(input[i])){
			*source1 += input[i];
			i++;
			while(isdigit(input[i])){
				*source1 += input[i];
				i++;
			}
			break;
		}
		else{
			cout << "variable or number expected" << endl;
			return false;
		}
	}
	// Check for whitespace
	while(isspace(input[i])){
		i++;
	}
	// Read operator
	switch(input[i]){
		case '+': case '-' : case '*' : case '^': 
			*op = input[i];
			break;
		default : 
			cout << "operator expected" << endl;
			return false;
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
			return false;
		}
		// Read integer
		while(isdigit(input[i])){
			*source2 += input[i];
			i++;
		}
		// Check for end of line
		if(i < size){
			cout << "end of line expected" << endl;
			return false;
		}
		return true;
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
			*source2 = input[i];
			i++;
			break;
		}
		else if(isdigit(input[i])){
			*source2 += input[i];
			i++;
			while(isdigit(input[i])){
				*source2 += input[i];
				i++;
			}
			break;
		}
		else{
			cout << "variable or number expected" << endl;
			return false;
		}
	}
		// Check for end of line
		if(i < size){
			cout << "end of line expected" << endl;
			return false;
		}
	}
	return true;
}



int main(){
	LinkedList<int> a;
	a.append(0);
	LinkedList<int> b;
	b.append(0);
	LinkedList<int> c;
	c.append(0);
	LinkedList<int> d;
	d.append(0);
	LinkedList<int> e;
	e.append(0);
	LinkedList<int> f;
	f.append(0);
	LinkedList<int> g;
	g.append(0);
	LinkedList<int> h;
	h.append(0);
	LinkedList<int> i;
	i.append(0);
	LinkedList<int> j;
	j.append(0);
	LinkedList<int> k;
	k.append(0);
	LinkedList<int> l;
	l.append(0);
	LinkedList<int> m;
	m.append(0);
	LinkedList<int> n;
	n.append(0);
	LinkedList<int> o;
	o.append(0);
	LinkedList<int> p;
	p.append(0);
	LinkedList<int> q;
	q.append(0);
	LinkedList<int> r;
	r.append(0);
	LinkedList<int> s;
	s.append(0);
	LinkedList<int> t;
	t.append(0);
	LinkedList<int> u;
	u.append(0);
	LinkedList<int> v;
	v.append(0);
	LinkedList<int> w;
	w.append(0);
	LinkedList<int> x;
	x.append(0);
	LinkedList<int> y;
	y.append(0);
	LinkedList<int> z;
	z.append(0);
	LinkedList<int> temp1;
	LinkedList<int> temp2;

	//LinkedList<int>* first = &a;
	//LinkedList<int>* last = &z;
	//LinkedList<int>* current = &a;

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
		validate = parseString(inputString, &destination, &source1, &source2, &op);
		// Find integer values or register for first source value
		switch(source1[0]){
			case 'a': break;
			case 'b': break;
			case 'c': break;
			case 'd': break;
			case 'e': break;
			case 'f': break;
			case 'g': break;
			case 'h': break;
			case 'i': break;
			case 'j': break;
			case 'k': break;
			case 'l': break;
			case 'm': break;
			case 'n': break;
			case 'o': break;
			case 'p': break;
			case 'q': break;
			case 'r': break;
			case 's': break;
			case 't': break;
			case 'u': break;
			case 'v': break;
			case 'w': break;
			case 'x': break;
			case 'y': break;
			case 'z': break;
			default:
				int size = source1.length();
				int iterator = size - 1;
				int ones, tens, hunds, thous, result;
				while(size > 0){
					if(size < 4){
						switch(size){
							case 3:
								ones = source1[iterator] - '0';
								iterator--; 
								tens = (source1[iterator] - '0') * 10;
								iterator--;
								hunds = (source1[iterator] - '0') * 100;
								iterator--;
								result = hunds + tens + ones;
								temp1.append(result);	
								break;	
							case 2:
								ones = source1[iterator] - '0';
								iterator--; 
								tens = (source1[iterator] - '0') * 10;
								iterator--; 
								result = tens + ones;
								temp1.append(result);
								break;
							case 1:
								ones = source1[iterator] - '0';
								iterator--; 
								result = ones;
								temp1.append(result);
								break;
						}
						size = 0;
					}
					else{
						//temp1.append(std::stoi(source1.substr(iterator, 4)));
						ones = source1[iterator] - '0';
						iterator--; 
						tens = (source1[iterator] - '0') * 10;
						iterator--;
						hunds = (source1[iterator] - '0') * 100;
						iterator--;
						thous = (source1[iterator] - '0') * 1000;
						iterator--;
						result = thous + hunds + tens + ones;
						temp1.append(result);
						size -= 4;
					}
				}
				temp1.printList();
			}
			
		// Find integer values or register for second source value
		switch(source2[0]){
			case 'a': break;
			case 'b': break;
			case 'c': break;
			case 'd': break;
			case 'e': break;
			case 'f': break;
			case 'g': break;
			case 'h': break;
			case 'i': break;
			case 'j': break;
			case 'k': break;
			case 'l': break;
			case 'm': break;
			case 'n': break;
			case 'o': break;
			case 'p': break;
			case 'q': break;
			case 'r': break;
			case 's': break;
			case 't': break;
			case 'u': break;
			case 'v': break;
			case 'w': break;
			case 'x': break;
			case 'y': break;
			case 'z': break;
			default:
				int size = source2.length();
				int iterator = size - 1;
				int ones, tens, hunds, thous, result;
				while(size > 0){
					if(size < 4){
						switch(size){
							case 3:
								ones = source2[iterator] - '0';
								iterator--; 
								tens = (source2[iterator] - '0') * 10;
								iterator--;
								hunds = (source2[iterator] - '0') * 100;
								iterator--;
								result = hunds + tens + ones;
								temp2.append(result);	
								break;	
							case 2:
								ones = source2[iterator] - '0';
								iterator--; 
								tens = (source2[iterator] - '0') * 10;
								iterator--; 
								result = tens + ones;
								temp2.append(result);
								break;
							case 1:
								ones = source2[iterator] - '0';
								iterator--; 
								result = ones;
								temp2.append(result);
								break;
						}
						size = 0;
					}
					else{
						//temp1.append(std::stoi(source1.substr(iterator, 4)));
						ones = source2[iterator] - '0';
						iterator--; 
						tens = (source2[iterator] - '0') * 10;
						iterator--;
						hunds = (source2[iterator] - '0') * 100;
						iterator--;
						thous = (source2[iterator] - '0') * 1000;
						iterator--;
						result = thous + hunds + tens + ones;
						temp2.append(result);
						size -= 4;
					}
				}
				temp2.printList();
			}
			
		// Find destination register
		switch(destination[0]){
			case 'a': 
				calculate(a, s1, s2, op);
				break;
			case 'b': 
				calculate(b, s1, s2, op);
				break;
			case 'c': 
				calculate(c, s1, s2, op);
				break;
			case 'd': 
				calculate(d, s1, s2, op);
				break;
			case 'e': 
				calculate(e, s1, s2, op);
				break;
			case 'f': 
				calculate(f, s1, s2, op);
				break;
			case 'g': 
				calculate(g, s1, s2, op);
				break;
			case 'h': 
				calculate(h, s1, s2, op);
				break;
			case 'i': 
				calculate(i, s1, s2, op);
				break;
			case 'j': 
				calculate(j, s1, s2, op);
				break;
			case 'k': 
				calculate(k, s1, s2, op);
				break;
			case 'l': 
				calculate(l, s1, s2, op);
				break;
			case 'm': 
				calculate(m, s1, s2, op);
				break;
			case 'n': 
				calculate(n, s1, s2, op);
				break;
			case 'o':
				calculate(o, s1, s2, op);
				break;
			case 'p': 
				calculate(p, s1, s2, op);
				break;
			case 'q': 
				calculate(q, s1, s2, op);
				break;
			case 'r': 
				calculate(r, s1, s2, op);
				break;
			case 's': 
				calculate(s, s1, s2, op);
				break;
			case 't': 
				calculate(t, s1, s2, op);
				break;
			case 'u': 
				calculate(u, s1, s2, op);
				break;
			case 'v': 
				calculate(v, s1, s2, op);
				break;
			case 'w': 
				calculate(w, s1, s2, op);
				break;
			case 'x': 
				calculate(x, s1, s2, op);
				break;
			case 'y': 
				calculate(y, s1, s2, op);
				break;
			case 'z': 
				calculate(z, s1, s2, op);
				break;
		// Print values to be calculated
		cout << "destination: " << destination << endl;
		cout << "source 1: " << source1 << endl;
		cout << "operator: " << op << endl;
		cout << "source 2: " << source2 << endl;
	}

	return 0;
}
		/*
		if(!validate){

		}
		else{
			int i = 0;
			// Read first character for destination
			destination = inputString[0];
			i++;
			// Check for whitespace
			while(isspace(inputString[i])){
				i++;
			}
			// Pass over = sign
			i++;
			// Check for whitespace
			while(isspace(inputString[i])){
				i++;
			}
			// Read register or integer
			if(islower(inputString[i])){
				source1 = inputString[i];
				i++;
			}
			else if(isdigit(inputString[i])){
				source1 = inputString[i];
				i++;
				while(isdigit(inputString[i])){
					source1 += inputString[i];
					i++;
				}
			}
			// Check for whitespace
			while(isspace(inputString[i])){
				i++;
			}
			// Read operator
			op = inputString[i];
			i++;
			// Check for whitespace
			while(isspace(inputString[i])){
				i++;
			}
			// Read register or integer
			if(op == "^"){
				source2 = inputString[i];
				i++;
				while(isdigit(inputString[i])){
					source2 += inputString[i];
					i++;
				}
			}
			else{
				if(islower(inputString[i])){
					source2 = inputString[i];
					i++;
				}
				else if(isdigit(inputString[i])){
					source2 = inputString[i];
					i++;
					while(isdigit(inputString[i])){
						source2 += inputString[i];
						i++;
					}
				}
			}
		}
		*/