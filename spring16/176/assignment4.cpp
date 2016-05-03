/*  Author: Brandon Lundberg
    File Name: assignment4.cpp
    Purpose: Using OpenMP
    Date: 21 April 2016
*/

/*
    Global Documentation
    Compiling:                   > g++ -fopenmp assingnment4.cpp
    Setting Number of threads:   > export OMP_NUM_THREADS=[insert number of threads]
    Running:                     > ./a.out [insert array size]

    Example:
    ➜  176 git:(master) ✗ g++ -fopenmp assignment4.cpp
    ➜  176 git:(master) ✗ export OMP_NUM_THREADS=2
    ➜  176 git:(master) ✗ ./a.out 10000

    The program goes through the following procedure
    1. Initiallize the 3 arrays and assigns the same random values to each one
    2. Display the initial contents of the arrays
    3. Sort the array using the correct implementation from the assignment description, and display the computation time for that sort
    4. Run a check over each algorithm that shows correctness
    5. Display the final contents of the array

*/

#include <stdlib.h>
#include <iostream>
#include <string.h>
#include <omp.h>
#include <sys/wait.h> //for wait()
#include <sys/time.h> //for macro GET_TIME(double)

using namespace std;

#define GET_TIME(now)\
{ struct timeval t; gettimeofday(&t, NULL);\
  now = t.tv_sec + t.tv_usec/1000000.0; }

// Check that the array is sorted
bool isArraySorted(int a[], int n)
{
  for(int i = 0; i < n- 1; i++)
  {
    if(a[i] > a[i + 1])
    {
       cout << a[i] << " is greater than " << a[i + 1] << endl;
       return false;
    }
  }
  return true;
}
// Serial count sort implementation
void count_sort_serial(int a[], int n) {
  int i, j, count;
  int* temp = (int*)malloc(n*sizeof(int));
  for (i = 0; i < n; i++) {
    count = 0;
    for (j = 0; j < n; j++)
      if (a[j] < a[i])
        count++;
      else if (a[j] == a[i] && j < i)
        count++;
    temp[count] = a[i];
  }
  for(i = 0; i < n; i++)
    a[i] = temp[i];
  //memcpy(a, temp, n * sizeof(int));
  free(temp);
}
// Parallel count sort 1 (sort is parallel, memcpy section is not)
void count_sort_parallel1(int a[], int n) {
  int* temp = (int*)malloc(n*sizeof(int));
  #pragma omp parallel for
    for (int i = 0; i < n; i++) {
      int count = 0;
      for (int j = 0; j < n; j++)
        if (a[j] < a[i] || (a[j] == a[i] && j < i))
          count++;
      temp[count] = a[i];
    }
  for(int i = 0; i < n; i++)
    a[i] = temp[i];
  //memcpy(a, temp, n * sizeof(int));
  free(temp);
}

// Parallel count sort 1 (sort and memcpy sections are both parallel)
void count_sort_parallel2(int a[], int n) {
  int* temp = (int*)malloc(n*sizeof(int));
  #pragma omp parallel for
    for (int i = 0; i < n; i++) {
      int count = 0;
      for (int j = 0; j < n; j++)
        if (a[j] < a[i] || (a[j] == a[i] && j < i))
          count++;
      temp[count] = a[i];
    }
  #pragma omp parallel for
    for(int i = 0; i < n; i++)
      a[i] = temp[i];
  //memcpy(a, temp, n * sizeof(int));
  free(temp);
}

int main(int argc, char* argv[])
{

  // Convert the command line inputs to integers
  // int numThreads = atoi(argv[1]);
  int n = atoi(argv[1]);
  // Declare Arrays
  int serial_array[n];
  int parallel_array_1[n];
  int parallel_array_2[n];
  // Initialize Seed
  srand (time(NULL));

  // Initialize array values with random values
  for(int i = 0; i < n; i++){
    // Generate random number
    int r = rand() % n;
    serial_array[i] = r;
    parallel_array_1[i] = r;
    parallel_array_2[i] = r;
  }
  // Display initial values of each array
  if(n >= 40) // Enough values to show first and last 20
  {
    // Serial Array
    cout << "Initial Serial Array:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << serial_array[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
    // Parallel Array 1
    cout << "Initial Parallel Array 1:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << parallel_array_1[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
    // Parallel Array 2
    cout << "Initial Parallel Array 2:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << parallel_array_2[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
  }
  else // Not enough values, show all values
  {
    // Serial Array
    cout << "Initial Serial Array:" << endl;
    for(int i = 0; i < n; i++)
      cout << serial_array[i] << " ";
    cout << endl;
    // Parallel Array 1
    cout << "Initial Parallel Array 1:" << endl;
    for(int i = 0; i < n; i++)
      cout << parallel_array_1[i] << " ";
    cout << endl;
    // Parallel Array 2
    cout << "Initial Parallel Array 2:" << endl;
    for(int i = 0; i < n; i++)
      cout << parallel_array_2[i] << " ";
    cout << endl;
  }
  cout << endl;


  // variables for time checking
  double start, stop, total;

  // Sorting Each Array
  // Serial count sort
  cout << "Sorting serial array..." << endl;
  // Start timer when threads are created and begin running
  GET_TIME(start);
  count_sort_serial(serial_array, n);
  // Stop timer. All threads have finished computation at this point
  GET_TIME(stop);
  // Calculate and print execution time
  total = stop - start;
  cout << "Total computation time: " << total << endl << endl;

  // Parallel count sort 1
  cout << "Sorting parallel array 1..." << endl;
  // Start timer when threads are created and begin running
  GET_TIME(start);
  count_sort_parallel1(parallel_array_1, n);
  // Stop timer. All threads have finished computation at this point
  GET_TIME(stop);
  // Calculate and print execution time
  total = stop - start;
  cout << "Total computation time: " << total << endl << endl;

  // Parallel count sort 2
  cout << "Sorting parallel array 2..." << endl;
  // Start timer when threads are created and begin running
  GET_TIME(start);
  count_sort_parallel2(parallel_array_2, n);
  // Stop timer. All threads have finished computation at this point
  GET_TIME(stop);
  // Calculate and print execution time
  total = stop - start;
  cout << "Total computation time: " << total << endl << endl;

  cout << endl;

  // Verifying sorts
  bool isSorted = false;
  // Serial Array
  isSorted = isArraySorted(serial_array, n);
  cout << "Serial Array Sorted?: ";
  if(isSorted) cout << "Yes!" << endl;
  else cout << "No..." << endl;
  // Parallel Array 1
  isSorted = isArraySorted(parallel_array_1, n);
  cout << "Parallel Array 1 Sorted?: ";
  if(isSorted) cout << "Yes!" << endl;
  else cout << "No..." << endl;
  // Parallel Array 2
  isSorted = isArraySorted(parallel_array_2, n);
  cout << "Parallel Array 2 Sorted?: ";
  if(isSorted) cout << "Yes!" << endl;
  else cout << "No..." << endl;
  cout << endl;

  // Display final values of each array
  if(n >= 40) // Enough values to show first and last 20
  {
    // Serial Array
    cout << "Final Serial Array:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << serial_array[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
    // Parallel Array 1
    cout << "Final Parallel Array 1:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << parallel_array_1[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
    // Parallel Array 2
    cout << "Final Parallel Array 2:" << endl;
    for(int i = 0; i < n; i++){
      if(i < 20 || n - i < 21) cout << parallel_array_2[i] << " ";
      if(i == 20) cout << "... ";
    }
    cout << endl;
  }
  else // Not enough values, show all values
  {
    // Serial Array
    cout << "Final Serial Array:" << endl;
    for(int i = 0; i < n; i++)
      cout << serial_array[i] << " ";
    cout << endl;
    // Parallel Array 1
    cout << "Final Parallel Array 1:" << endl;
    for(int i = 0; i < n; i++)
      cout << parallel_array_1[i] << " ";
    cout << endl;
    // Parallel Array 2
    cout << "Final Parallel Array 2:" << endl;
    for(int i = 0; i < n; i++)
      cout << parallel_array_2[i] << " ";
    cout << endl;
  }
  cout << endl;
}


