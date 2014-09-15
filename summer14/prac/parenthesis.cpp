#include <iostream>
using namespace std;
#include "Stack.h"
#include <cstring>
#define SIZE 10

int main(){
	Stack ops [SIZE];// = new Stack <string>();
	Stack ans [SIZE];// = new Stack <double>(); 

	string infix[SIZE*2] = "2 + 4) * 6) - 3) * 2) / 4)";
	//strcpy("2 + 4) * 6) - 3) * 2) / 4)", infix);
	while(char ch = getchar() != NULL){
		if(ch >= '0' && ch <= '9')
			ans.push(ch - '0');
	}
	return 0;
}
 