/*
	Author:		Brandon Lundberg
	File Name:	driver.cpp
	Purpose:	Instantiation of a BST and test cases proving the invariant
	Date:		23 March 2015
*/
#include <iostream>
#include <cstdlib>
using namespace std;
#include "BST.h"

int main(){
	ModifiedBST *tree = new ModifiedBST();
	// Insert a bunch of values 
	// Running a printKeys function from key 1 to n nodes will show if the values were inserted correctly. If the values are ordered least to greatest in that function call, the inserted were sucessful
	tree -> insert(5);
	tree -> insert(2);
	tree -> insert(1);
	tree -> insert(8);
	tree -> insert(7);
	tree -> insert(23);
	tree -> insert(3);
	tree -> insert(17);
	tree -> insert(11);
	tree -> insert(10);
	tree -> insert(6);
	tree -> insert(99);
	tree -> insert(0);
	tree -> insert(9);
	tree -> insert(20);
	tree -> insert(15);
	cout << "Keys from 1 to n: " << endl;
	tree -> printKeys(1,tree -> m_nodes);
	cout << endl;
	// Kth smallest key
	// We can assume if insert is correct, then as long as the input to kthSmallest is equal to the value displayed in the print keys function from above are the same, the test are correct
	cout << "2nd smallest: ";
	cout << tree -> kthSmallest(tree -> m_root, 2) << endl;
	cout << "5th smallest: ";
	cout << tree -> kthSmallest(tree -> m_root, 5) << endl;
	cout << "7th smallest: ";
	cout << tree -> kthSmallest(tree -> m_root, 7) << endl;
	cout << "11th smallest: ";
	cout << tree -> kthSmallest(tree -> m_root, 11) << endl;
	cout << "14th smallest: ";
	cout << tree -> kthSmallest(tree -> m_root, 14) << endl;
	cout << endl << endl;
	// Test print keys
	// Just as stated for kthSmallest, if this function prints keys from key1 to key2 in order, the function  correctly
	cout << "Keys from 4 to 13: " << endl;
	tree -> printKeys(4, 13);
	cout << "Keys from 1 to 3: " << endl;
	tree -> printKeys(1, 3);
	cout << "Keys from 11 to 15: " << endl;
	tree -> printKeys(11, 15);
	cout << "Keys from 1 to 14: " << endl;
	tree -> printKeys(1,14);
	cout << "Keys from 8 to 10: " << endl;
	tree -> printKeys(8,10);
	// :)

	return 0;
}