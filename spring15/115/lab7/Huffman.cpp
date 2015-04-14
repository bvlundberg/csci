/*
	Author:		Brandon Lundberg
	File Name:	Huffman.cpp
	Purpose:	Holds the implementation of the Huffman coding classes and function
	Date:		5 April 2015
*/
#include "Heap.cpp"
#include "Huffman.h"


LeafNode :: LeafNode (const E& val, int freq) // Constructor
		{ it = val; wgt = freq; }
int LeafNode :: weight() { return wgt; }
		E val() { return it; }
bool LeafNode :: isLeaf() { return true; }


IntlNode :: IntlNode(HuffNode<E>* l, HuffNode<E>* r)
			{ wgt = l->weight() + r->weight(); lc = l; rc = r; }
int  IntlNode :: weight() { return wgt; }
bool IntlNode :: isLeaf() { return false; }
HuffNode<E>* IntlNode :: left() const { return lc; }
void IntlNode :: setLeft(HuffNode<E>* b)
				{ lc = (HuffNode<E>*)b; }
HuffNode<E>* IntlNode :: right() const { return rc; }
void IntlNode :: setRight(HuffNode<E>* b)
			{ rc = (HuffNode<E>*)b; }


static bool prior(HuffNode<E>* e1, HuffNode<E>* e2){
			return e1.weight() <= e2.weight();
		}

HuffTree :: HuffTree(E& val, int freq) // Leaf constructor
		{ Root = new LeafNode<E>(val, freq); }
	// Internal node constructor
HuffTree :: HuffTree(HuffTree<E>* l, HuffTree<E>* r)
		{ Root = new IntlNode<E>(l->root(), r->root()); }
HuffTree :: ~HuffTree() {} // Destructor
HuffNode<E>* HuffTree :: root() { return Root; } // Get root
int HuffTree :: weight() { return Root->weight(); } // Root weight
