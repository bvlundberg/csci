/*	Author: Brandon Lundberg
	File Name: hanoiModified.cpp
	Purpose: solve the modified hanoi tower problem
	Date: 4 Feb 2015
*/

#include <cstdlib>
#include <iostream>
using namespace std;

void hanoiTower(int n, int currPole, int destPole){
	if(n == 1){
		cout << currPole << " " << destPole << endl;
		return;
	}
	int other;
	if(currPole == 1){
		if(destPole == 2){
			other = 3;
		}
		else{
			other = 2;
		}
	}
	else if(currPole == 2){
		if(destPole == 1){
			other = 3;
		}
		else{
			other = 1;
		}
	}
	else{
		if(destPole == 1){
			other = 2;
		}
		else{
			other = 1;
		}
	}

	hanoiTower(n-1, currPole, other);
	hanoiTower(1, currPole, destPole);
	hanoiTower(n-1, other, destPole);
	return;
}

int main(){
	int n;
	cin >> n;

	//hanoiTower(n, 1, 2);
	//hanoiTower(2n, 2, 3);
	int i = n;
	if(i % 2 == 0){
		hanoiTower(n, 1, 3);
	}
	for(i; i > 0; i--){
		if(i % 2 == 0){
			cout << 2 << " " << 1 << endl;
			hanoiTower(2*n-i, 3, 1);
		}
		else{
			cout << 2 << " " << 3 << endl;
			hanoiTower(2*n-i, 1, 3);
		}
	}
	return 0;
}