/*	Author:		Brandon Lundberg
	File Name:	calculator.h
	Purpose:	Holds the functions needed for the calculator
	Date:		9 March 2015
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