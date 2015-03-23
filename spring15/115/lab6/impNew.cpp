/*
	Author:		Brandon Lundberg
	File Name:	implementation.cpp
	Purpose:	BST implementation
	Date:		23 March 2015
*/
#include <iostream>
#include <cstdlib>
using namespace std;
#include "BST.h"
		/* 	Inserting a node into a tree uses 2 functions
				Function 1
				Insert - this function is used as the initial call, checking the root to see if there are any nodes in the tree. 
				If there is no root of the tree, a node is added with a key of 1. This ensures that a tree with only 1 node has the right key-value pairs (1 pair)
				If there is a root, the value to be inserted is compared to the root. Depending on the comparison, the value will be inserted in the left or right subtree. If the value is to inserted into the left subtree, the values in the right subtree need to be incremented by 1. The description for incrementKeys is below to expain.
				Function 2
				Very similar to insert, but insertHelper takes a node pointer, key and value as parameters. As the tree is searched for the correct place to insert the node, the parameters for the recursive insertHelper function change, and the incrementKeys function can change keys in the subtrees.
				Inserting a node into the tree only travels down the necessary path to insert the value. However, the incrementKeys function will touch every node with a key that is greater than the current key. I believe this takes more than log n time. I am still happy with my solution
		*/
		void BST::insert(int value){
			/*	Check if tree is null
				Create a node to be the root of the tree and increment the number of nodes in the tree
			*/
			if(m_root == NULL){
				m_root = new Node(1, value);
				m_nodes++;
				return;
			}
			else{
				/* Case where value is greater than the current nodes value. Key will be at least one higher than that of the current node, so change the parameter for the key to one more than the key of the current node
				*/
				if(value > m_root -> m_value){
					m_root -> m_right = insertHelper(m_root -> m_right, m_root -> m_key+1, value);
				}
				/* Case where value is less than the current nodes value. Key for the recursive call will be less than or equal to the key of the current node. This case also calls the increment keys function. Since the value will be inserted in the left subtree of the current node, all values of the current node and its right subtree will be incremented by 1
				*/
				else{
					m_root -> m_left = insertHelper(m_root -> m_left, m_root -> m_key, value);
					m_root -> m_key++;
					incrementKeys(m_root -> m_right);
				}
			}
		}
		/* This function does much of the same as insert, but it also updates the right and left subtrees of the current node by using node -> m_right/m_left =
		*/
		Node* BST::insertHelper(Node *node, int key, int value){
			if(node == NULL){
				m_nodes++;
				return new Node(key, value);
			}
			else if(value > node -> m_value){
				node -> m_right = insertHelper(node -> m_right, node -> m_key+1, value);

			}
			else{
				node -> m_left = insertHelper(node -> m_left, node -> m_key, value);
				node -> m_key++;
				incrementKeys(node -> m_right);
			}
			return node;
		}
		int BST::kthSmallest(Node *node, int key){
			// Key not in the tree
			if(key < 0 || key > m_nodes){
				cout << "Key not found in tree" << endl;
				return -1;
			}
			// Key found, return value
			else if(key == node -> m_key){
				return node -> m_value;
			}
			// traverse left
			else if(key < node -> m_key){
				return kthSmallest(node -> m_left, key);
			}
			// traverse right
			else{
				return kthSmallest(node -> m_right, key);
			}
		}

		void BST::printKeys(int key1, int key2){
			int nodesVisited = 0;
			if(key1 > key2){
				cout << "Cannot print in reverse order. Make sure your first key is less than your second key!" << endl;
				return;
			}
			else if(key1 < 0 || key2 > m_nodes){
				cout << "One of the keys not in range of the nodes allocated" << endl;
				return;
			}
			modifiedInOrderTraversal(m_root, key1, key2, nodesVisited);
			cout << "Nodes Visited: " << nodesVisited << endl << endl;
			//preOrderTraversal(m_root);
			//cout << "Nodes: " << m_nodes << endl;
		}
		/* Used for testing 
		void inOrderTraverse(Node *node){
			if(node == NULL){
				return;
			}

			inOrderTraverse(node -> m_left);
			cout << "Key: " << node -> m_key << " " << "Value: " << node -> m_value << endl;
			inOrderTraverse(node -> m_right);
		}
		*/
		void BST::modifiedInOrderTraversal(Node *node, int key1, int key2, int &nodesVisited){
			// Emtpy
			if(node == NULL){
				return;
			}
			// Non-null node has been visited
			nodesVisited++;
			/* 	Case where key1 is found
				Print result, then traverse right to find keys greater than key 1
			*/
			if (node -> m_key == key1){
				cout << "Key: " << node -> m_key << " " << "Value: " << node -> m_value << endl;
				modifiedInOrderTraversal(node -> m_right, key1, key2, nodesVisited);
			}
			/* 	Case where key2 is found
				Traverse left to find keys less than key 2, then print key2
			*/
			else if (node -> m_key == key2){
				modifiedInOrderTraversal(node -> m_left, key1, key2, nodesVisited);
				cout << "Key: " << node -> m_key << " " << "Value: " << node -> m_value << endl;
			}
			/* 	Case where current key is in between key 1 and 2
				Traverse left
				Print value of current key
				Traverse right

			*/
			else if(node -> m_key > key1 && node -> m_key < key2){
				modifiedInOrderTraversal(node -> m_left, key1, key2, nodesVisited);
				cout << "Key: " << node -> m_key << " " << "Value: " << node -> m_value << endl;
				modifiedInOrderTraversal(node -> m_right, key1, key2, nodesVisited);
			}
			/* 	Case where current key is less than key 1
				Key 1 could be in right subtree, so traverse right
			*/
			else if(node -> m_key < key1){
				modifiedInOrderTraversal(node -> m_right, key1, key2, nodesVisited);
			}
			/* 	Case where current key is greater than key 2
				Key 2 could be in left subtree, so traverse left
			*/
			else{
				modifiedInOrderTraversal(node -> m_left , key1, key2, nodesVisited);
			}
		}
		/* Used for testing
		void preOrderTraversal(Node *node){
			if(node == NULL){
				return;
			}
			cout << "Key: " << node -> m_key << " " << "Value: " << node -> m_value << endl;
			preOrderTraversal(node -> m_left);
			preOrderTraversal(node -> m_right);
		} 
		*/
		/* 	Function to increment the keys of all nodes in a tree.
			This function ensure on insert that the keys with values greater than the current value being inserted are changed occordingly. The root of a tree is passed in originally. The function does a pre order traversal to recursively increment the tree's keys.
		*/
		void BST::incrementKeys(Node *node){
			if(node == NULL){
				return;
			}
			node -> m_key++;
			incrementKeys(node -> m_left);
			incrementKeys(node -> m_right);
		}
