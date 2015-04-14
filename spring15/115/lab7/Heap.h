/*
	Author:		Brandon Lundberg
	File Name:	Heap.h
	Purpose:	Holds the abstract heap class
	Date:		5 April 2015
*/
// Heap class

template <typename E, typename Comp> class heap {
	private:
		E* Heap;
		int maxsize;
		int n;
		// Helper function to put element in its correct place
		void siftdown(int pos);
	public:
		heap() {}
		int size() const; // Return current heap size
		bool isLeaf(int pos) const; // True if pos is a leaf
		int leftchild(int pos) const; // Return leftchild position
		int rightchild(int pos) const; // Return rightchild position
		int parent(int pos) const; // Return parent position
		void buildHeap(); // Heapify contents of Heap
		// Insert "it" into the heap
		void insert(const E& it);
		// Remove first value
		E removefirst();
		// Remove and return element at specified position
		E remove(int pos);
};