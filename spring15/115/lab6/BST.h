#ifndef BST_H
#define BST_H
/*
	Author:		Brandon Lundberg
	File Name:	BST.h
	Purpose:	Holds the BST class
	Date:		23 March 2015
*/
class Node{
	public:
		Node *m_left;
		Node *m_right;
		int m_key;
		int m_value;
		Node(int key, int value){
			m_key = key;
			m_value = value;
		}
};
class BST{
	public:
		Node *m_root;
		int m_nodes;
		BST(){
			m_root = NULL;
			m_nodes = 0;
		}

};
#endif