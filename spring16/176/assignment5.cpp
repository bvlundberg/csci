/*
    Author: Brandon Lundberg
    File Name: assignment5.cpp
    Purpose: Parallel Merge Sort with MPI
    Date: 3 May 2016
*/

/*
    Global Documentation
    Compiling:                   > mpic++ assignment5.cpp
    Running:                     > mpirun -np 4 ./a.out

    Example:
    ➜  176 git:(master) ✗ mpic++ assignment5.cpp
    ➜  176 git:(master) ✗ mpirun -np 4 ./a.out

    The program goes through the following procedure
    1. Receive the command line arguments, into variable 'n'
    2. Each process creatCes a local array with size 'n', filled with random values between 0 and n - 1
    3. Process 0 receives local lists from each process and displays them in order. This is essentially our otiginal unsorted list
    4. Each process will run quicksort (qsort) on its local unsorted array
    5. Use tree reduction on combine results by merging the each local list together. The final sorted list will be in process 0
    6. In process 0, display the final results
*/

#include <stdlib.h>
#include <iostream>
#include <string.h>
#include <mpi.h>

using namespace std;
// Function that fills an array with random values from 0 to n - 1
void fillarray(int a[], int id, int n, int p)
{
  // Random seed using process id
  srand(id + 1);
  for(int i = 0; i < n / p; i++) a[i] = rand() % n;
  return;
}

// Check that the array is sorted
bool isArraySorted(int a[], int n)
{
  for(int i = 0; i < n- 1; i++)
  {
    if(a[i] > a[i + 1])
    {
       // Print error with the sort
       cout << a[i] << " is greater than " << a[i + 1] << endl;
       return false;
    }

  }
  return true;
}

// Compare function used for qsort function
int compare (const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}

// Quicksort function
void localsort(int a[], int id, int n, int p)
{
  // Sort the first n / p elements of the array (only spaces that were filled)
  qsort (a, n / p, sizeof(int), compare);
  return;
}

// Merge sort function
// Takes two filled lists and a temporary list
// The temporary list overwrites list 'a' in the main program
void merge(int a[], int b[], int c[], int size)
{
  // Counters
  int a1 = 0, b1 = 0, c1 = 0;
  // While there are still values in an array
  while(a1 < size && b1 < size)
  {
    // Element in list a is less than element in list b
    if(a[a1] < b[b1])
    {
      c[c1] = a[a1];
      c1++;
      a1++;
    }
    // Element in list b is less than element in list a
    else
    {
      c[c1] = b[b1];
      c1++;
      b1++;
    }
  }
  // List a values that need to be moved over
  while(a1 < size)
  {
    c[c1] = a[a1];
    c1++;
    a1++;
  }
  // List b values that need to be moved over
  while(b1 < size)
  {
    c[c1] = b[b1];
    c1++;
    b1++;
  }
}

int main(int argc, char* argv[])
{
  // Problem size
  int n = 400;
  // Rank and number of threads for MPI
  int rank, comm_sz;
  // Lists used during sort process
  int a[n], b[n], temp[n];

  // Initialize lists with zeros
  for(int i = 0; i < n; i++)
  {
    a[i] = 0;
    b[i] = 0;
    temp[i] = 0;
  }
  
  // MPI
  MPI_Init(NULL, NULL);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);

  // Display problem parameters
  if(rank == 0)
  {
    cout << "Problem Size: " << n << endl;
    cout << "Number of Threads: " << comm_sz << endl;
    cout << endl;
  }

  // Create local arrays in each process
  fillarray(a, rank, n, comm_sz);
  
  // Display initial array from process 0
  if(rank != 0)
  {
    // Send values to process 0 for displaying
    MPI_Send(&a, n, MPI_INT, 0, 0, MPI_COMM_WORLD);
  }
  else
  {
    // Display local list values
    cout << "Array from process 0: " << endl;
    for(int j = 0; j < n / comm_sz; j++) cout << a[j] << " ";
    cout << endl << endl;
    // Receive lists from other processes, in order of rank, and display
    for(int i = 1; i < comm_sz; i++)
    {
      MPI_Recv(&b, n, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      cout << "Array from process " << i << ": " << endl;
      for(int j = 0; j < n / comm_sz; j++) cout << b[j] << " ";
      cout << endl << endl;
    }
  }

  // Sort local array in each process
  localsort(a, rank, n, comm_sz);

  /*********************************************** 
  This section was used to check that each local array is sorted. It can be ignored  
  if(rank != 0)
  {
    MPI_Send(&a, n, MPI_INT, 0, 0, MPI_COMM_WORLD);
  }
  else
  {
    for(int i = 1; i < comm_sz; i++)
    {
      MPI_Recv(&b, n, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      //cout << "Array " << i << " sorted:" << endl;
      //for(int j = 0; j < n / comm_sz; j++) cout << b[j] << " ";
      //cout << endl;
    }
  }
  ******************************************************/
  
  // Tree reduction of local arrays back into process 0
  int divisor = 2;
  int rank_diff = 1;
  // Size is the current amount of the array to be merged
  int size = n / comm_sz;
  
  while(rank_diff < comm_sz)
  {
    // Receiever
    if(rank % divisor == 0)
    {
      int partner = rank + rank_diff;
      MPI_Recv(&b, n, MPI_INT, partner, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      merge(a, b, temp, size);
      for(int i = 0; i < size * 2; i++) a[i] = temp[i];
    }
    // Sender
    else
    {
      int partner = rank - rank_diff;
      MPI_Send(&a, n, MPI_INT, partner, 0, MPI_COMM_WORLD);
      break;
    }
    rank_diff *= 2;
    divisor *= 2;
    size *= 2;
  }

  // Display results from process 0
  if(rank == 0)
  {
    // Verifying sort
    bool isSorted = false;
    isSorted = isArraySorted(a, n);
    cout << "Array Sorted?: ";
    if(isSorted) cout << "Yes!" << endl;
    else cout << "No..." << endl;
    cout << endl;

    // Display the final result
    cout << "Final sorted array:" << endl;
    for(int i = 0; i < n; i++)
      cout << a[i] << " ";
  }
  cout << endl;
  MPI_Finalize();
  return 0;
}