#include <iostream>
using namespace std;
#include "SLL.h"

int main(){
	//Initialize Polynomials
	SLL *poly1 = new SLL();
	SLL *poly2 = new SLL();
	SLL *poly3 = new SLL();
	// User input of polynomial specifications
	poly1->enterInfo(1);
	poly2->enterInfo(2);
	poly3->enterInfo(3);
	// Print out the details of each polynomial
	poly1->printSLL(1);
	poly2->printSLL(2);
	poly3->printSLL(3);	
	
	// Degree Functions
	cout << "Polynomial 1 highest degree: " << poly1->degree() << endl;
	cout << "polynomial 2 highest degree: " << poly2->degree() << endl;
	cout << "polynomial 3 highest degree: " << poly3->degree() << endl;
	// Coefficient Functions
	cout << "X Coefficient 3 of polynomail 1: " << poly1->coefficient(3) << endl;
	cout << "X Coefficient 2 of polynomail 2: " << poly2->coefficient(2) << endl;
	cout << "X Coefficient 1 of polynomail 3: " << poly3->coefficient(1) << endl;
	// Match Functions
	cout << "Polynomial 1 match Polynomial 2?: ";
		if(poly1->match(poly2))
			cout << "True" << endl;
		else
			cout << "False" << endl;
	cout << "Polynomial 1 match Polynomial 3?: ";
		if(poly1->match(poly3))
			cout << "True" << endl;
		else
			cout << "False" << endl;
	
	// Sum Function
	poly1->sum(poly3);
	cout << "After sum function--" << endl;
	poly1->printSLL(1);

	// Dot Function
	poly2->dot(poly3);
	cout << "After dot function--" << endl;
	poly2->printSLL(2);
	delete poly1;
	delete poly2;
	delete poly3;
	return 0;
}