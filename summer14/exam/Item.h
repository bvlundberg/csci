

#ifndef Item_H
#define Item_H

#include <iostream>
#include <string>
using namespace std;
class Item
{
public:
	
	Item(string description, int priority)
	{
		str = description;
        this->priority = priority;
	}
	Item(){}
	~Item() {}
	string getDescription()  { return str; }
	void setDescription(string description) { str = description; }
	int getPriority() { return priority; }
	void setPriority(int priority) { this->priority = priority; }
private:
	string str;
    int priority;
    
};
#endif /* Item_H */
