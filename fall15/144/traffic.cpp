/*	Author: 	Brandon Lundberg
	Filename:	traffic.cpp
	Purpose:	Implement a traffic light using multithreading
	Date: 		2 December 2015
*/

#define NUM_CARS 50
#define DIRECTIONS 4
#define CARS_NORTH 15
#define CARS_EAST 15
#define CARS_SOUTH 15
#define CARS_WEST 15

// 0: North
// 1: East
// 2: South
// 3: West

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

class Lane{
	private:
		Lock lock;
		Queue queue;
}; 

class Intersection{
	private:
		int arrivalCount;
		int passCount;
		int passPerGreen; // n can pass per green light

	public:
		Intersection()
		{
			OpenStreet();
		};
		~Intersection() {};
		void OpenStreet() 	// Loop to open street
		{
			
			printf("Street is open!");
			while(1)
			{
				WaitForCar();
			}

		} 			
		void EnterIntersection();	// Called by cars

	private:
		void WaitForCar();
		void PrintIntersectionStats();

		bool ReachedPassingLimit();
};

class Car{
	private:
		int direction;	// North: 0, East: 1, South:2, West: 3
		int entrytime;
		int exittime;
	public:
		Car(int d){
			direction = d;
		}
	private:
		void donePassing();
};

void *ManageIntersection(){
	Intersection intersection = new Intersection();
	intersection.OpenStreet(0);
	pthread_exit(NULL);
}

void *ManageNorth(){
	for(int i = 0; i < CARS_NORTH; i++){
		Car c = new Car();
		NorthQueueAddCar(c);

	}
	thread_exit(NULL);
}

void *NorthQueueAddCar(Car c){
	North.lock.acquire();
	North.queue.push(c);
	North.lock.release();
}

void *ManageEast(){

	thread_exit(NULL);
}

void *ManageSouth(){

	thread_exit(NULL);
}

void *ManageWest(){

	thread_exit(NULL);
}


Lane North;
Lane East;
Lane South;
Lane West;

int main(){
	// Instantiate lanes
	North = new Lane();
	East = new Lane();
	South = new Lane();
	West = new Lane();
	// Global variables for the intersection thread and each direction thread
	pthread_t intersectionThread;
	pthread_t directionThreads[DIRECTIONS];
	// Create intersection thread and open the street
	pthread_create(intersectionThread, NULL, ManageIntersection, NULL);

	// Start each car thread after a random sleep time
	pthread_create(&directionThreads[0], NULL, ManageNorth, NULL);
	pthread_create(&directionThreads[1], NULL, ManageEast, NULL);
	pthread_create(&directionThreads[2], NULL, ManageSouth, NULL);
	pthread_create(&directionThreads[3], NULL, ManageWest, NULL);
	}
	pthread_exit(NULL);
}

