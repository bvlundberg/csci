//////////////////////////////
//// Park -- this is a C++ version of the Pthread Hello program
////
//// compile and run:
//// $> g++ -o Hello Hello.cpp -lpthread 
//// $>./Hello 4
////   //4 is the number of threads to create - any
//////////////////////////////

#include <iostream>
#include <cstdlib> //for atoi()
#include <pthread.h> 
using namespace std;

//globals --accessible to all threads
int thread_count;       //for command line arg

void *Hello(void* rank); //prototype for a Thread function

///////////////////
int main(int argc, char* argv[]) 
{
  long thread_id; //long for type conversion [long<-->void*] for 64 bit system

  thread_count = atoi(argv[1]); //tot number of threads - from command line
  pthread_t myThreads[thread_count]; //define threads 
  
  //creates a certain number of threads
  for(thread_id = 0; thread_id < thread_count; thread_id++)  
     pthread_create(&myThreads[thread_id], NULL, Hello, (void*)thread_id);  

  cout<<"Hello from the main thread"<<endl;
    
  //wait until all threads finish
  for(thread_id = 0; thread_id < thread_count; thread_id++) 
     pthread_join(myThreads[thread_id], NULL); 

  return 0;
}//main

//////////////////slave function
void *Hello(void* rank) 
{
  int my_rank = (long)rank; //rank is void* type, so can cast to (long) type only; 
  
  cout<<"Hello from thread_"<<my_rank<<" of "<<thread_count<<endl;
   
  return NULL;
}//Hello