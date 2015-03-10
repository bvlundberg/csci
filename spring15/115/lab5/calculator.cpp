/*	Author:		Brandon Lundberg
	File Name:	calculator.cpp
	Purpose:	Holds the functions needed for the calculator
	Date:		9 March 2015
*/

class Calculator{
	private:
	public:
		LinkedList<int> a;
		LinkedList<int> b;
		LinkedList<int> c;
		LinkedList<int> d;
		LinkedList<int> e;
		LinkedList<int> f;
		LinkedList<int> g;
		LinkedList<int> h;
		LinkedList<int> i;
		LinkedList<int> j;
		LinkedList<int> k;
		LinkedList<int> l;
		LinkedList<int> m;
		LinkedList<int> n;
		LinkedList<int> o;
		LinkedList<int> p;
		LinkedList<int> q;
		LinkedList<int> r;
		LinkedList<int> s;
		LinkedList<int> t;
		LinkedList<int> u;
		LinkedList<int> v;
		LinkedList<int> w;
		LinkedList<int> x;
		LinkedList<int> y;
		LinkedList<int> z;
		LinkedList<int> temp1;
		LinkedList<int> temp2;

		//LinkedList<int>* d1;
		//LinkedList<int>* s1;
		//LinkedList<int>* s2;

		Calculator(){
			a.append(0);
			b.append(0);
			c.append(0);
			d.append(0);
			e.append(0);
			f.append(0);
			g.append(0);
			h.append(0);
			i.append(0);
			j.append(0);
			k.append(0);
			l.append(0);
			m.append(0);
			n.append(0);
			o.append(0);
			p.append(0);
			q.append(0);
			r.append(0);
			s.append(0);
			t.append(0);
			u.append(0);
			v.append(0);
			w.append(0);
			x.append(0);
			y.append(0);
			z.append(0);

			//LinkedList<int>* d1 = &(a);
			//LinkedList<int>* s1 = &(temp1);
			//LinkedList<int>* s2 = &(temp2);
		}
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

	LinkedList<int>* identifySource(string value, int temp){
		LinkedList<int>* source;
		switch(value[0]){
				case 'a': 
					source = &a;
					break;
				case 'b': 
					source = &b;
					break;
				case 'c': 
					source = &c;
					break;
				case 'd': 
					source = &d;
					break;
				case 'e': 
					source = &e;
					break;
				case 'f': 
					source = &f;
					break;
				case 'g': 
					source = &g;
					break;
				case 'h': 
					source = &h;
					break;
				case 'i': 
					source = &i;
					break;
				case 'j': 
					source = &j;
					break;
				case 'k': 
					source = &k;
					break;
				case 'l': 
					source = &l;
					break;
				case 'm': 	
					source = &m;
					break;
				case 'n': 
					source = &n;
					break;
				case 'o': 
					source = &o;
					break;
				case 'p': 
					source = &p;
					break;
				case 'q': 	
					source = &q;
					break;
				case 'r': 
					source = &r;
					break;
				case 's': 
					source = &s;
					break;
				case 't': 
					source = &t;
					break;
				case 'u': 
					source = &u;
					break;
				case 'v': 
					source = &v;
					break;
				case 'w': 
					source = &w;
					break;
				case 'x': 
					source = &x;
					break;
				case 'y': 
					source = &y;
					break;
				case 'z': 
					source = &z;
					break;
				default:
					if(temp == 1){
						source = &temp1;
					}
					else{
						source = &temp2;
					}
					source -> clear();
					int size = value.length();
					int iterator = size - 1;
					int ones, tens, hunds, thous, result;
					while(size > 0){
						if(size < 4){
							switch(size){
								case 3:
									ones = value[iterator] - '0';
									iterator--; 
									tens = (value[iterator] - '0') * 10;
									iterator--;
									hunds = (value[iterator] - '0') * 100;
									iterator--;
									result = hunds + tens + ones;
									source -> append(result);	
									break;	
								case 2:
									ones = value[iterator] - '0';
									iterator--; 
									tens = (value[iterator] - '0') * 10;
									iterator--; 
									result = tens + ones;
									source -> append(result);
									break;
								case 1:
									ones = value[iterator] - '0';
									iterator--; 
									result = ones;
									source -> append(result);
									break;
							}
							size = 0;
						}
						else{
							//source.append(std::stoi(value.substr(iterator, 4)));
							ones = value[iterator] - '0';
							iterator--; 
							tens = (value[iterator] - '0') * 10;
							iterator--;
							hunds = (value[iterator] - '0') * 100;
							iterator--;
							thous = (value[iterator] - '0') * 1000;
							iterator--;
							result = thous + hunds + tens + ones;
							source -> append(result);
							size -= 4;
						}
					}
				}
				return source;
	}
	LinkedList<int>* identifyDestination(string value){
		LinkedList<int>* destination;
		switch(value[0]){
			case 'a': 
				destination = &a;
				break;
			case 'b': 
				destination = &b;
				break;
			case 'c': 
				destination = &c;
				break;
			case 'd': 
				destination = &d;
				break;
			case 'e': 
				break;
			case 'f': 
				destination = &f;
				break;
			case 'g': 
				destination = &g;
				break;
			case 'h': 
				destination = &h;
				break;
			case 'i': 
				destination = &i;
				break;
			case 'j': 
				destination = &j;
				break;
			case 'k': 
				destination = &k;
				break;
			case 'l': 
				destination = &l;
				break;
			case 'm': 
				destination = &m;
				break;
			case 'n': 
				destination = &n;
				break;
			case 'o':
				destination = &o;
				break;
			case 'p': 
				destination = &p;
				break;
			case 'q': 
				destination = &q;
				break;
			case 'r': 
				destination = &r;
				break;
			case 's': 
				destination = &s;
				break;
			case 't': 
				destination = &t;
				break;
			case 'u': 
				destination = &u;
				break;
			case 'v': 
				destination = &v;
				break;
			case 'w': 
				destination = &w;
				break;
			case 'x': 
				destination = &x;
				break;
			case 'y': 
				destination = &y;
				break;
			case 'z': 
				destination = &z;
				break;
			}
			return destination;
	}

	void printList(LinkedList<int> *reg){
	    	Link<int> *iterator = reg -> getHead() -> next;
	    	Link<int> *tail = reg -> getTail();
	    	cout << "Values in the list: ";
	    	while(iterator != tail){
	    		cout << iterator -> element << " ";
	    		iterator = iterator -> next;
	    	}
	    	cout << endl;
	}
	void calculate(LinkedList<int> *destination, LinkedList<int> *source1, LinkedList<int> *source2, string op){
		destination -> clear();
		switch(op[0]){
			case '+': 
				addition(destination, source1, source2);
				break;
			case '-' :
				subtraction(destination, source1, source2);
				break;
			case '*' :
				multiply(destination, source1, source2);
				break;
			case '^':
				exponential(destination, source1, source2); 
				break;
		}
	}

	void addition(LinkedList<int> *destination, LinkedList<int> *source1, LinkedList<int> *source2){
		Link<int>* sourceLink1 = source1 -> getHead() -> next;
		Link<int>* sourceLink2 = source2 -> getHead() -> next;
		Link<int>* tail1 = source1 -> getTail();
		Link<int>* tail2 = source2 -> getTail();
		int carry = 0;
		int result = 0;
		while(1){
			if(sourceLink1 == tail1 && sourceLink2 == tail2){
				if(carry != 0){
					destination -> append(carry);
				}
				break;
			}
			else if(sourceLink1 != tail1 && sourceLink2 != tail2){
				// calculate sourceLink1 + source 2 + carry
				result = sourceLink1 -> element + sourceLink2 -> element + carry;
				// append to the destination register
				if(result >= 10000){
					destination -> append(result % 10000);
				}
				else{
					destination -> append(result);
				}
				// find carry value
				carry = result / 10000;
				// go to next links
				sourceLink1 = sourceLink1 -> next;
				sourceLink2 = sourceLink2 -> next;

			}
			else if(sourceLink1 != tail1){
				// calculate sourceLink1 + carry
				result = sourceLink1 -> element + carry;
				// append to the destination register
				if(result >= 10000){
					destination -> append(result % 10000);
				}
				else{
					destination -> append(result);
				}
				// find carry value
				carry = result / 10000;
				// go to next link
				sourceLink1 = sourceLink1 -> next;
			}
			else{
				// calculate sourceLink2 + carry
				result = sourceLink2 -> element + carry;
				// append to the destination register
				if(result >= 10000){
					destination -> append(result % 10000);
				}
				else{
					destination -> append(result);
				}
				// find carry value
				carry = result / 10000;
				// go to next link
				sourceLink2 = sourceLink2 -> next;
			}
	    }
	    return;
	}
	void subtraction(LinkedList<int> *destination, LinkedList<int> *source1, LinkedList<int> *source2){
		
	}
	void multiply(LinkedList<int> *destination, LinkedList<int> *source1, LinkedList<int> *source2){
		
	}
	int exponential(LinkedList<int> *destination, LinkedList<int> *source1, LinkedList<int> *source2){
		/*
		Link<int>* sourceLink1 = source1 -> getHead() -> next;
		Link<int>* sourceLink2 = source2 -> getHead() -> next;
        if(sourceLink2 -> element == 1){
        	return sourceLink1 -> element;
        }
        else if(sourceLink2 -> element % 2 == 1){
        	return exponential(destination, source1, (sourceLink2 -> element) / 2) * sourceLink1 -> element;
        }
        else{
        	return exponential(destination, sourceLink1, (sourceLink2 -> element) / 2);
        }
        */
	}
};