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
using namespace std;
#define HASHSIZE 4001

int sfold(char* key) {
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
		void update(char *key){
			numProbes = 0;
			updates[numElements]++;
			int pos = sfold(key);
			if(array[pos] == NULL){
				keyValue *kv = new keyValue();
				kv -> m_key = key;
				kv -> m_occurences = 1;
				array[pos] = kv;
				numElements++;
				//updates[pos] = 1;
			}
			else if(array[pos] -> m_key == key){
				array[pos] -> m_occurences += 1;
			}
			else{
				//next(&pos, key);
				int i = 1;
				numProbes++;
				while(i < HASHSIZE - 1 && array[((pos + i) % HASHSIZE)] != NULL){
					i++;
					numProbes++;
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
		void next(char *key, int &value){
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
			char *key;
			int value;
			while(curr != HASHSIZE){
				next(key, value);
				cout << "Key: " << key << " Value: " << value << endl;
			}
			
		}

};

int main(){
	hashTable ht;
	ht.update("A");
	ht.update("B");

	ht.traverse();
	//cout << sfold("B");
	cout << ht.array[65]->m_key << " " << ht.array[65]->m_occurences << endl;
	cout << ht.array[66]->m_key << " " << ht.array[66]->m_occurences << endl;

	return 0;
}