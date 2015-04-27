/*		Author: 	Brandon Lundberg
		File Name: 	rjhash.cpp
		Purpose:	Hashing
		Date: 		20 April 2015
*/
#include <iostream>
#include <stdlib.h>
#include <cstring>
#include <ctype.h>
#include <string>
#include <fstream>
#include <iomanip>
using namespace std;
#define HASHSIZE 4001

int sfold(const char* key) {
	unsigned int *lkey = (unsigned int *)key;
	int intlength = strlen(key)/4;
	unsigned int sum = 0;
	for(int i = 0; i < intlength; i++)
	sum += lkey[i];
	// Now deal with the extra chars at the end
	int extra = strlen(key) - intlength * 4;
	char temp[4];
	lkey = (unsigned int *)temp;
	lkey[0] = 0;
	for(int i = 0; i < extra; i++)
	temp[i] = key[intlength * 4 + i];
	sum += lkey[0];
	return sum % HASHSIZE;
}

class keyValue{
	public:
		string m_key;
		int m_occurences;
		keyValue(){
			m_key = "";
			m_occurences = 0;
		}
};

class hashTable{
	public:
		keyValue **array;
		int updates[HASHSIZE];
		int cost[HASHSIZE];
		int numElements;
		int numProbes;
		int curr;
		hashTable(){
			array = new keyValue*[HASHSIZE];
			for(int i = 0; i < HASHSIZE; i++){
				array[i] = NULL;
				updates[i] = 0;
				cost[i] = 0;
			}
			numElements = 0;
			numProbes = 0;
			curr = -1;
		}
		int size(){
			return numElements;
		}
		void update(const char *skey){
			
			numProbes = 0;
			updates[numElements]++;
			int pos = sfold(skey);
			string key = string(skey);
			if(array[pos] == NULL){
				keyValue *kv = new keyValue();
				kv -> m_key = key;
				kv -> m_occurences = 1;
				array[pos] = kv;
				numElements++;
			}
			else if(array[pos] -> m_key == key){
				array[pos] -> m_occurences += 1;
			}
			else{
				int i = 1;
				numProbes++;
				while(i <= HASHSIZE && array[(pos + i) % HASHSIZE] != NULL){
					if(array[(pos + i) % HASHSIZE] -> m_key == key){
						array[pos] -> m_occurences += 1;
						return;
					}
					else{
						i++;
						numProbes++;
					}
				}
				pos += i;
				keyValue *kv = new keyValue();
				kv -> m_key = key;
				kv -> m_occurences = 1;
				array[pos] = kv;
				cost[numElements] += numProbes;
				numElements++;
				
			}
			
			
		}
		int probes(){
			return numProbes;
		}
		int reset(){
			curr = -1;
		}
		void next(string &key, int &value){
			curr++;
			while(curr != HASHSIZE && array[curr] == NULL){
				curr++;
			}
			if(curr == HASHSIZE){
				key = "";
				value = -1;
			}
			else{
				key = array[curr] -> m_key;
				value = array[curr] -> m_occurences;
			}
		}
		void traverse(){
			reset();
			string key;
			int value;
			while(curr != HASHSIZE){
				next(key, value);
				cout << "Key: " << key << " Value: " << value << endl;
			}
			
		}
		/*
		void swap(int x, int y){
			keyValue *temp = array[x];
			array[x] = array[y];
			array[y] = temp; 
		}
		int findPivot(int i, int j){
			return (i+j)/2;
		}

		int partition(int left, int right, keyValue *pivot){
			while(left <= right){
				while(array[left] -> m_occurences < pivot -> m_occurences){
					left++;
				}
				while((right >= left) && (array[right] -> m_occurences >= pivot -> m_occurences)){
					right--;
				}
				if(right > left){
					swap(left++, right--);
				}
				return left;
			}
		}

		void quickSort(int i, int j){
		  int pivot = findPivot(i, j);
		  swap(pivot, j); 
		  int k = partition(i, j-1, array[j]);
		  swap(k, j);                   
		  if ((k-i) > 1) quickSort(i, k-1);
		  if ((j-k) > 1) quickSort(k+1, j);
			return;
		}
		*/

};



int main(){
	hashTable ht;
	// Read from file and update
    ifstream file;
    file.open ("RomeoAndJuliet.txt");
    if (!file.is_open()) return 0;

    string word;
    while (file >> word){
    	ht.update(const_cast<char*>(word.c_str()));
	}
	// Generate csv
	for(int i = 1; i < HASHSIZE; i++){
		
		if(ht.updates[i] == 0){
			if(ht.cost[i] != 0){
				cout << "Divide by zero!" << endl << endl;
				break;
			}
			else{
				cout << "0.00,";	
			}
		}
		else{
			cout << setprecision(1) << float(ht.cost[i])/float(ht.updates[i]) << ",";
		}

	}
	// Unique words
	cout << endl;
	cout << "Unique words: " << ht.size() << endl;
	// Sort for top occurances
	hashTable htSorted;
	htSorted = ht;
	//htSorted.quickSort(0,HASHSIZE);

	return 0;
}