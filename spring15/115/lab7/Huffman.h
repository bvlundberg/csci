// Huffman tree node abstract base class
template <typename E> class HuffNode {
	public:
		virtual ˜HuffNode() {} // Base destructor
		virtual int weight() = 0; // Return frequency
		virtual bool isLeaf() = 0; // Determine type
		};

template <typename E> // Leaf node subclass
class LeafNode : public HuffNode<E> {
	private:
		E it; // Value
		int wgt; // Weight
	public:
		LeafNode(const E& val, int freq) // Constructor
		{ it = val; wgt = freq; }
		int weight() { return wgt; }
		E val() { return it; }
		bool isLeaf() { return true; }
		};

template <typename E> // Internal node subclass
class IntlNode : public HuffNode<E> {
	private:
		HuffNode<E>* lc; // Left child
		HuffNode<E>* rc; // Right child
		int wgt; // Subtree weight
	public:
		IntlNode(HuffNode<E>* l, HuffNode<E>* r)
			{ wgt = l->weight() + r->weight(); lc = l; rc = r; }
		int weight() { return wgt; }
		bool isLeaf() { return false; }
		HuffNode<E>* left() const { return lc; }
			void setLeft(HuffNode<E>* b)
				{ lc = (HuffNode<E>*)b; }
		HuffNode<E>* right() const { return rc; }
		void setRight(HuffNode<E>* b)
			{ rc = (HuffNode<E>*)b; }
};

template <typename E>
class HuffTree {
	private:
		HuffNode<E>* Root; // Tree root
	public:
	HuffTree(E& val, int freq) // Leaf constructor
		{ Root = new LeafNode<E>(val, freq); }
	// Internal node constructor
	HuffTree(HuffTree<E>* l, HuffTree<E>* r)
		{ Root = new IntlNode<E>(l->root(), r->root()); }
	˜HuffTree() {} // Destructor
	HuffNode<E>* root() { return Root; } // Get root
	int weight() { return Root->weight(); } // Root weight
};

template <typename Comp>
class minTreeComp {
	private:

	public:
		bool prior(HuffNode<E>* e1, HuffNode<E>* e2){
			return e1.weight() <= e2.weight();
		}

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