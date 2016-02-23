/*  Author: Brandon Lundberg
    File Name: homework1.cpp
    Purpose: Use the fibonacci sequence functions to practice message passing through
    piping. Three child processes are created from the main program. The first is used as a controller
    to receive input from the main program, pass the input to the other processes, and receive the
    result. The other two processes receive the input, calculate the result, and return the
    result to the controller.
*/

#include <unistd.h>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <sys/wait.h> //for wait()
#include <sys/time.h> //for macro GET_TIME(double)

using namespace std;


//macro (in-line expansion) for GET_TIME(double); needs <sys/time.h>
#define GET_TIME(now)\
{ struct timeval t; gettimeofday(&t, NULL);\
  now = t.tv_sec + t.tv_usec/1000000.0; }
// Parse the input from a string to an integer
// Input: string inout from user
// Output: index used for fibonacci functions
int stringToInt(string input)
{
  try
  {
    return stoi(input);
  }
  catch(...)
  {
    cout << "Invalid Entry. Try Again" << endl;
    return -1;
  }
}
// Recursive implementation of the fibonacci function
// Input: Index of nth fibonacci number
// Output: nth fibonacci number
double fib_r(double n)
{
  if(n == 1 || n == 2)
  {
     return 1;
  }
  else
  {
     return fib_r(n-1) + fib_r(n-2);
  }
}
// Iterative implementation of the fibonacci function
// Input: Index of nth fibonacci number
// Output: nth fibonacci number
double fib_i(double n)
{
  if(n == 1 || n == 2)
  {
    return 1;
  }
  else
  {
    double p1 = 1, p2 = 1, temp = 0;
    for(int i = 0; i < n - 2; i++)
    {
      temp = p2;
      p2 += p1;
      p1 = temp;
    }
    return p2;
  }
}

int main()
{
	int pid, status;
  // Pipes
  // controller is the pipe from main process to first child process
  // recursive and iterative are the pipes from the first child process to the second and third
  // recursivefinish and iterativefinish are the pipes from the second and third processes back to the first
	int controller[2], recursive[2], iterative[2], recursivefinish[2], iterativefinish[2];
  int n_int = -1;
  string input = "";
  // Parse until a valid input is received
  while(n_int == -1)
  {
      cout << "Please enter a number to be used for the fibonacci calculator: ";
      cin >> input;
      n_int = stringToInt(input);
  }

  double n = (double)n_int;
  cout << "n: " << n << endl;

	pipe(controller);
	pipe(recursive);
	pipe(iterative);
  pipe(recursivefinish);
	pipe(iterativefinish);

  // Pass input to first child
  write(controller[1], &n, sizeof(double));
	for(int i = 0; i < 3; i++)
	{
		pid = fork();
    // First child (controller)
		if(pid == 0 && i == 0)
		{
      double controllerinput;
      double recursiveresult, iterativeresult;
      // Read input from main
      read(controller[0], &controllerinput, sizeof(double));
      // Write input to other children
      write(recursive[1], &controllerinput, sizeof(double));
      write(iterative[1], &controllerinput, sizeof(double));
      // Receive result from other children
      read(recursivefinish[0], &recursiveresult, sizeof(double));
      read(iterativefinish[0], &iterativeresult, sizeof(double));

      cout << "Recursive execution time: " << recursiveresult << " seconds" << endl;
      cout << "Iterative execution time: " << iterativeresult << " seconds" << endl;
			exit(0);
		}
    // Second child (recursive)
		else if(pid == 0 && i == 1)
		{
      double recursiveinput, recursiveanswer = 0;
      double start_r, stop_r, executiontime_r;
      // Receive input from controller
      read(recursive[0], &recursiveinput, sizeof(double));
      GET_TIME(start_r);
      recursiveanswer = fib_r(recursiveinput);
      GET_TIME(stop_r);
      executiontime_r = stop_r - start_r;
      cout << "Recursive Result: " << recursiveanswer << endl;
      // Pass result back to controller
      write(recursivefinish[1], &executiontime_r, sizeof(double));
			exit(0);
		}
    // Third child (iterative)
		else if(pid == 0 && i == 2)
		{
      double iterativeinput, iterativeanswer = 0;
      double start_i, stop_i, executiontime_i;
      // Receive input from controller
      read(iterative[0], &iterativeinput, sizeof(double));
      GET_TIME(start_i);
      iterativeanswer = fib_i(iterativeinput);
      GET_TIME(stop_i);
      executiontime_i = stop_i - start_i;
      cout << "Iterative Result: " << iterativeanswer << endl;
      // Pass result back to controller
      write(iterativefinish[1], &executiontime_i, sizeof(double));
			exit(0);
		}
	}
  // Wait for processes to end
  for(int i = 0; i < 3; i++)
  {
    pid = wait(&status);
    cout << "Child with pid " << pid << " exited, status=" << status << endl;
  }
}