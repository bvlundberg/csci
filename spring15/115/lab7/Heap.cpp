#include "Heap.h"

heap :: heap(E* h, int num, int max) // Constructor
			{ Heap = h; n = num; maxsize = max; buildHeap(); }

void heap :: siftdown(int pos) {
			while (!isLeaf(pos)) { // Stop if pos is a leaf
				int j = leftchild(pos); int rc = rightchild(pos);
				if ((rc < n) && Comp::prior(Heap[rc], Heap[j]))
				j = rc; // Set j to greater child’s value
				if (Comp::prior(Heap[pos], Heap[j])) return; // Done
				swap(Heap, pos, j);
				pos = j; // Move down
			}
		}

int heap :: size() const; // Return current heap size
			{ return n; }

int heap :: leftchild(int pos) const 
			{ return (pos >= n/2) && (pos < n); }

int heap :: rightchild(int pos) const;
			{ return 2*pos + 2; } // Return rightchild position
int heap :: parent(int pos) const; // Return parent position
			{ return (pos-1)/2; }
void heap :: buildHeap() // Heapify contents of Heap
			{ for (int i=n/2-1; i>=0; i--) siftdown(i); }
		// Insert "it" into the heap
void heap :: insert(const E& it) {
			//Assert(n < maxsize, "Heap is full");
			int curr = n++;
			Heap[curr] = it; // Start at end of heap
			// Now sift up until curr’s parent > curr
			while ((curr!=0) &&
			(Comp::prior(Heap[curr], Heap[parent(curr)]))) {
			swap(Heap, curr, parent(curr));
				curr = parent(curr);
			}
		}// Remove first value
E heap :: removefirst() {
			//Assert (n > 0, "Heap is empty");
			swap(Heap, 0, --n); // Swap first with last value
			if (n != 0) siftdown(0); // Siftdown new root val
			return Heap[n]; // Return deleted value
		}
		// Remove and return element at specified position
E heap :: remove(int pos) {
			//Assert((pos >= 0) && (pos < n), "Bad position");
			if (pos == (n-1)) n--; // Last element, no work to do
			else
			{
			swap(Heap, pos, --n); // Swap with last value
			while ((pos != 0) &&
			(Comp::prior(Heap[pos], Heap[parent(pos)]))) {
			swap(Heap, pos, parent(pos)); // Push up large key
			pos = parent(pos);
			}
			if (n != 0) siftdown(pos); // Push down small key
			}
			return Heap[n];
		}