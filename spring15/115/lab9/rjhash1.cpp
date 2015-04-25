#include <iostream>
#include <fstream>
#include <array>
#include <iomanip>
#include <math.h> 
#include <cstring>
#define HASHSIZE 4001
#define EMPTYKEY ""

using namespace std;

struct keyValue
{
	string key;
	int value;
};

class Hash {
private:
	array<keyValue, HASHSIZE> data;
	array<int, HASHSIZE> updates;
	array<int, HASHSIZE> cost;
	int c_size;
	int curr;

public:
	Hash(){
		for(int i = 0; i < HASHSIZE; i++){
			data[i].key = "";
			data[i].value = 0;
			updates[i] = 0;
			cost[i] = 0;
		}
		c_size = 0;
		curr = -1;
	}
	int size(){ return c_size; };
	void reset(){ curr = -1; }
	int count(int index){ return data[index].value; }
	int probes(){ return cost[c_size - 1]; } // Double check this

	void update(const char *key){
		int index = sfold(key);
		string str_key = string(key);
		// Increment the number of updates for current size
		updates[c_size]++; 

		// Check if the string is not empty
		if (data[index].key != ""){
			// Check if the string is the same
			if (data[index].key == str_key){
				data[index].value++;
			}
			// String is different, do probing
			else {
				int current = index;
				// Doing probing here
				while(data[current].key != EMPTYKEY && data[current].key != str_key){
					current = ++current % HASHSIZE; 
					cost[c_size]++;
				}

				data[current].value++;
				if (data[current].key != str_key){
					data[current].key = str_key;
					c_size++;
				}
			}
		}
		else {
			// String is empty. Create new (key, value) pair
			data[index].key = str_key;
			data[index].value++;
			c_size++;
		}
	}

	void next(string &key, int &value){
		// Looking for the next element
		int i = curr;
		while(i < HASHSIZE){
			if (data[i].key == ""){
				key = data[i].key;
				value = data[i].value;
				return;
			}
			i++;
		}

		// Setting not found return values
		if (i + 1 == HASHSIZE){
			key = "";
			value = -1;
		}
	}

	int sfold(const char* key) {
		unsigned int *lkey = (unsigned int *)key;
		int intlength = strlen(key)/4;
		unsigned int sum = 0;
		
		for(int i=0; i<intlength; i++)
			sum += lkey[i];
		
		// Now deal with the extra chars at the end
		int extra = strlen(key) - intlength*4;
		char temp[4];
		lkey = (unsigned int *)temp;
		lkey[0] = 0;
		
		for(int i=0; i<extra; i++)
			temp[i] = key[intlength*4+i];
			sum += lkey[0];

		return sum % HASHSIZE;
	}

	void readFile(){
    ifstream file;
    file.open ("RomeoAndJuliet.txt");
    
    if (!file.is_open()) return;

    string word;
    while (file >> word){
    		update(word.c_str());
	    }
	}

	void swap(int i, int j){
		string temp = data[i].key;
		data[i].key = data[j].key;
		data[j].key = temp;

		int vtemp = data[i].value;
		data[i].value = data[j].value;
		data[j].value = vtemp;
	}

	inline int findpivot(int i, int j) { return (i+j)/2; }

	inline int partition(int l, int r, int& pivot) {
		do { 
			while (data[++l].value < pivot); 
			while ((l < r) && (pivot < data[--r].value)); 
			swap(l, r);
		} while (l < r); 
			return l; 
	}

	void qsort(int i, int j) {
		if (j <= i) return;
		int pivotindex = findpivot(i, j);
		swap(pivotindex, j); 
		int k = partition(i-1, j, data[j].value);
		swap(k, j); 
		qsort(i, k-1);
		qsort(k+1, j);
	}

	void viewHash(){
		for(int i = 0; i < HASHSIZE; i++){
			cout << "Key: "<< data[i].key << endl;
			cout << "Value: "<<data[i].value << endl;
		}
	}

	void viewOutput(){
		float ratio = 0.0;
		for(int i = 0; i < HASHSIZE; i++){
			// For i=3684 and on dont display data cause they are all 0
			if (updates[i] == 0 && cost[i] == 0){ return; }
			ratio = float(cost[i])/float(updates[i]);
			cout << fixed << setprecision(2) << ratio;
			cout << ", ";
		}
		cout << endl;
	}

	void mostUsed(){
		qsort(0, HASHSIZE - 1);

		cout << "24 most used words" << endl;
		int count = 1;
		for(int i = HASHSIZE - 1; i >= 0; i--){
			cout << count << ": " << data[i].key;
			cout << " (" << data[i].value << ")" << endl;
			if (count == 24){ return;}
			count++;
		}
	}

};

int main(){
	Hash *data = new Hash;
	data->readFile();
	data->viewOutput();
	cout << endl << "Number of unique words: " << data->size() << endl;
	data->mostUsed();
	return 0;
}