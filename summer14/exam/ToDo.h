
//#ifndef TODO2_H
//#define TODO2_H
#include <string>
#include "Item.h"
using namespace std;
class ToDo
{
public:
	ToDo(int size)
	{
        //we do not consider overflow. so make sure "size" is big enough.
		items = new Item[size];
		aux = new Item[size];
		current_size=0;
	}
	
	~ToDo()
	{
		delete [] items;
		delete [] aux;
	}
    
    //insert an Item to the end
	void insert(string description, int priority)
	{
        items[++current_size] = *(new Item(description, priority));
 
	}
    //before deleting an item, use merge sort and then delete the highest priorty item
	void mergeStart(){
		mergeSort(1, current_size);
	}
	void mergeSort(int l, int h){
		if(h <=l) return;
		int mid = l + ((h-l) / 2);
		mergeSort(l, mid);
		mergeSort(mid+1,h);
		merge(l, mid, h);
	}
	void merge(int l, int mid, int h){
		int i = l, j = mid+1;
		for(int x = l; x <= h; x++)
			aux[x] = items[x];
		for(int x = l; x <= h; x++){
			if(i > mid){items[x] = aux[j++];}
			else if(j > h){items[x] = aux[i++];}
			else if(aux[i].getPriority() > aux[j].getPriority()){items[x] = aux[j++];}
			else {items[x] = aux[i++];}
		}
	}
	Item action() //delete highest priority item from todo list.
	{
		mergeStart();
		return items[current_size--];
	}
    
private:
	Item* items; //array of Item as a container for heap
	Item* aux;
	int current_size; //keep track the number of Item in the array. starting from 0
    
    //you are free to add any functions if needed
};
//#endif 
