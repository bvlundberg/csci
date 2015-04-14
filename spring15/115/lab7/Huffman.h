/*
	Author:		Brandon Lundberg
	File Name:	Huffman.h
	Purpose:	Holds the abstract classes and functions for the Huffman coding
	Date:		5 April 2015
*/
// Huffman tree node abstract base class
template <typename E> class HuffNode {
	public:
		virtual ~HuffNode() {} // Base destructor
		virtual int weight() = 0; // Return frequency
		virtual bool isLeaf() = 0; // Determine type
		};

template <typename E> // Leaf node subclass
class LeafNode : public HuffNode<E> {
	private:
		E it; // Value
		int wgt; // Weight
	public:
		LeafNode(const E& val, int freq); // Constructor
		int weight();
		E val();
		bool isLeaf();
		};

template <typename E> // Internal node subclass
class IntlNode : public HuffNode<E> {
	private:
		HuffNode<E>* lc; // Left child
		HuffNode<E>* rc; // Right child
		int wgt; // Subtree weight
	public:
		IntlNode(HuffNode<E>* l, HuffNode<E>* r);
		int weight();
		bool isLeaf();
		HuffNode<E>* left() const;
		void setLeft(HuffNode<E>* b);
		HuffNode<E>* right() const;
		void setRight(HuffNode<E>* b);
};

template <typename E> 
class minTreeComp{
	public:
		static bool prior(HuffNode<E>* e1, HuffNode<E>* e2);
};

template <typename E>
class HuffTree {
	private:
		HuffNode<E>* Root; // Tree root
	public:
	HuffTree(E& val, int freq); // Leaf constructor
	// Internal node constructor
	HuffTree(HuffTree<E>* l, HuffTree<E>* r);
	~HuffTree() {} // Destructor
	HuffNode<E>* root();
	int weight();
};



// Build a Huffman tree from a collection of frequencies
template <typename E> HuffTree<E>*
buildHuff(HuffTree<E>** TreeArray, int count) {
	heap<HuffTree<E>*,minTreeComp>* forest =
	new heap<HuffTree<E>*, minTreeComp>(TreeArray,count, count);
	HuffTree<char> *temp1, *temp2, *temp3 = NULL;
	while (forest->size() > 1) {
		temp1 = forest->removefirst(); // Pull first two trees
		temp2 = forest->removefirst(); // off the list
		temp3 = new HuffTree<E>(temp1, temp2);
		forest->insert(temp3); // Put the new tree back on list
		delete temp1; // Must delete the remnants
		delete temp2; // of the trees we created
	}
	return temp3;
}