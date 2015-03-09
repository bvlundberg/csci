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

bool parseString(string input, string *destination, string *source1, string *source2, string *op);
void calculate(Link<int> *destination, Link<int> *source1, Link<int> *source2, string op);



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

	LinkedList<int>* d1 = &(a);
	LinkedList<int>* s1 = &(temp1);
	LinkedList<int>* s2 = &(temp2);

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
			case 'a': 
				s1 = &a;
				break;
			case 'b': 
				s1 = &b;
				break;
			case 'c': 
				s1 = &c;
				break;
			case 'd': 
				s1 = &d;
				break;
			case 'e': 
				s1 = &e;
				break;
			case 'f': 
				s1 = &f;
				break;
			case 'g': 
				s1 = &g;
				break;
			case 'h': 
				s1 = &h;
				break;
			case 'i': 
				s1 = &i;
				break;
			case 'j': 
				s1 = &j;
				break;
			case 'k': 
				s1 = &k;
				break;
			case 'l': 
				s1 = &l;
				break;
			case 'm': 	
				s1 = &m;
				break;
			case 'n': 
				s1 = &n;
				break;
			case 'o': 
				s1 = &o;
				break;
			case 'p': 
				s1 = &p;
				break;
			case 'q': 	
				s1 = &q;
				break;
			case 'r': 
				s1 = &r;
				break;
			case 's': 
				s1 = &s;
				break;
			case 't': 
				s1 = &t;
				break;
			case 'u': 
				s1 = &u;
				break;
			case 'v': 
				s1 = &v;
				break;
			case 'w': 
				s1 = &w;
				break;
			case 'x': 
				s1 = &x;
				break;
			case 'y': 
				s1 = &y;
				break;
			case 'z': 
				s1 = &z;
				break;
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
			case 'a': 
				s2 = &a;
				break;
			case 'b': 
				s2 = &b;
				break;
			case 'c': 
				s2 = &c;
				break;
			case 'd': 
				s2 = &d;
				break;
			case 'e': 
				s2 = &e;
				break;
			case 'f': 
				s2 = &f;
				break;
			case 'g': 
				s2 = &g;
				break;
			case 'h': 
				s2 = &h;
				break;
			case 'i': 
				s2 = &i;
				break;
			case 'j': 
				s2 = &j;
				break;
			case 'k': 
				s2 = &k;
				break;
			case 'l': 
				s2 = &l;
				break;
			case 'm': 	
				s2 = &m;
				break;
			case 'n': 
				s2 = &n;
				break;
			case 'o': 
				s2 = &o;
				break;
			case 'p': 
				s2 = &p;
				break;
			case 'q': 	
				s2 = &q;
				break;
			case 'r': 
				s2 = &r;
				break;
			case 's': 
				s2 = &s;
				break;
			case 't': 
				s2 = &t;
				break;
			case 'u': 
				s2 = &u;
				break;
			case 'v': 
				s2 = &v;
				break;
			case 'w': 
				s2 = &w;
				break;
			case 'x': 
				s2 = &x;
				break;
			case 'y': 
				s2 = &y;
				break;
			case 'z': 
				s2 = &z;
				break;
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
				d1 = &a;
				break;
			case 'b': 
				d1 = &b;
				break;
			case 'c': 
				d1 = &c;
				break;
			case 'd': 
				d1 = &d;
				break;
			case 'e': 
				d1 = &e;
				break;
			case 'f': 
				d1 = &f;
				break;
			case 'g': 
				d1 = &g;
				break;
			case 'h': 
				d1 = &h;
				break;
			case 'i': 
				d1 = &i;
				break;
			case 'j': 
				d1 = &j;
				break;
			case 'k': 
				d1 = &k;
				break;
			case 'l': 
				d1 = &l;
				break;
			case 'm': 
				d1 = &m;
				break;
			case 'n': 
				d1 = &n;
				break;
			case 'o':
				d1 = &o;
				break;
			case 'p': 
				d1 = &p;
				break;
			case 'q': 
				d1 = &q;
				break;
			case 'r': 
				d1 = &r;
				break;
			case 's': 
				d1 = &s;
				break;
			case 't': 
				d1 = &t;
				break;
			case 'u': 
				d1 = &u;
				break;
			case 'v': 
				d1 = &v;
				break;
			case 'w': 
				d1 = &w;
				break;
			case 'x': 
				d1 = &x;
				break;
			case 'y': 
				d1 = &y;
				break;
			case 'z': 
				d1 = &z;
				break;
		// Print values to be calculated
		calculate(d1 -> getHead(), s1 -> getHead(), s2 -> getHead(), op);
		cout << "destination: " << destination << endl;
		cout << "source 1: " << source1 << endl;
		cout << "operator: " << op << endl;
		cout << "source 2: " << source2 << endl;
		}
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

void calculate(Link<int> *destination, Link<int> *source1, Link<int> *source2, string op){
	
}