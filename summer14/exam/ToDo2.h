
//#ifndef TODO2_H
//#define TODO2_H
#include <string>
#include "Item.h"
using namespace std;
class ToDo2
{
public:
	ToDo2(int size)
	{
        //we do not consider overflow. so make sure "size" is big enough.
		items = new Item[size];
		current_size=0;
	}
	
	~ToDo2()
	{
		delete [] items;
	}
    
    void sink(int k, int n)
    {
        while(k*2 <= n){
        	int j = k*2;
        	if(items[j].getPriority() < items[j+1].getPriority())
        		j++;
        	if(j <= n)
        		swaps(k,j);
        	k = j;

        }
    }
    void swim(int k)

    {
        while(k > 1){
        	if(items[k].getPriority() > items[k/2].getPriority())
        		swaps(k, k/2);
        	k /= 2;
        }
    }
    
	void insert(string description, int priority)
	{
        items[++current_size] = *(new Item(description, priority));
        swim(current_size);
 
	}
	Item action() //perform the todo action and delete it from todo list.
	{
		int k = 1;
		for(k; k < current_size; k++){
			swim(k);
		}
		Item temp = items[1];
		swaps(1, current_size);
		current_size--;
		sink(1,current_size);
		return temp;
		
		//return items[current_size];
	}
    void swaps(int i, int j){
    	Item temp = items[i];
    	items[i] = items[j];
    	items[j] = temp;
    }

    
private:
	Item* items; //array of Item as a container for heap
	int current_size; //keep track the number of Item in the array. starting from 0
    
    //you are free to add any functions if needed
};
//#endif
