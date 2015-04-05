#include <cstdlib>      /* printf, NULL */
#include <string>
#include <stdio.h>
#include <ctype.h>
#include <iostream>
using namespace std;

//#include "Huffman.cpp"
/*
HuffTree<char>* buildTree(HuffTree<char> *TreeArray){
	while(cin >> val){
		cin >> weight;
		cout << val << endl;
		cout << weight << endl;
		// Add val and weight to new HuffTree
		TreeArray[i] = new HuffTree<char>(val, weight);	
	}
	HuffTree<char> *WorldTree = buildHuff(&TreeArray, i+1);
	return WorldTree;
}
*/
/*
void encode(HuffTree<char> *tree, string input){
	int size = input.length();
	int i = 1;
	string code;

	while(i < size){
		// Read Character
		value = input[i];
		// Get value from tree and print
		// code = get value
		
		// Go to next value
		i++;
	}
}
*/
/*
void decode(HuffTree<char> *tree, string input){
	int size = input.length();
	int i = 0;
	char code;
	HuffNode<char>* current;
	// Get rid of white space
	while(i < size){
		// Go to root
		current = tree -> root();	
		// Traverse tree to find value
		while(!current -> isLeaf()){
			if(input[i] == '0'){
				current = current -> left();
			}
			else{
				current = current -> right();
			}
			i++;
		//}	
		// Return value from leaf node
		cout << current -> val();
		// Begin new traversal
		i++;
	}
}
*/
int main(){
	int op;
	char val;
	int weight;
	string encodeString, decodeString;
	//HuffTree<char> *TreeArray[100];
	//HuffTree<char> *WorldTree;
	cout << "Enter the string";
	cin >> op;
	switch(op){
		case 1:
			//WorldTree = buildTree(TreeArray);
			break;
		case 2:
			cin >> encodeString;
			//encode(WorldTree, encodeString);
			break;
		case 3:
			cin >> decodeString;
			//decode(WorldTree, decodeString);
			break;
	}
	return 0;
}