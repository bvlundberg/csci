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

int fib_r(int n)
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

int fib_i(int n)
{
  if(n == 1 || n == 2)
  {
    return 1;
  }
  else
  {
    int p1 = 1, p2 = 1, temp = 0;
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
	int controller[2], recursive[2], iterative[2], recursivefinish[2], iterativefinish[2];
  int n = -1;
  string input = "";
  while(n == -1)
  {
      cout << "Please enter a number to be used for the fibonacci calculator: ";
      cin >> input;
      n = stringToInt(input);
  }

	pipe(controller);
	pipe(recursive);
	pipe(iterative);
  pipe(recursivefinish);
	pipe(iterativefinish);


  write(controller[1], &n, sizeof(int));
	for(int i = 0; i < 3; i++)
	{
		pid = fork();
		if(pid == 0 && i == 0)
		{
      int controllerinput;
      double recursiveresult, iterativeresult;
      read(controller[0], &controllerinput, sizeof(int));
      write(recursive[1], &controllerinput, sizeof(int));
      write(iterative[1], &controllerinput, sizeof(int));
      read(recursivefinish[0], &recursiveresult, sizeof(double));
      read(iterativefinish[0], &iterativeresult, sizeof(double));

      cout << "Recursive execution time: " << recursiveresult << endl;
      cout << "Iterative execution time: " << iterativeresult << endl;
			exit(0);
		}
		else if(pid == 0 && i == 1)
		{
      int recursiveinput, recursiveanswer = 0;
      double start_r, stop_r, executiontime_r;
      read(recursive[0], &recursiveinput, sizeof(int));
      GET_TIME(start_r);
      recursiveanswer = fib_r(recursiveinput);
      GET_TIME(stop_r);
      executiontime_r = stop_r - start_r;
      cout << "Recursive Result: " << recursiveanswer << endl;
      write(recursivefinish[1], &executiontime_r, sizeof(double));
			exit(0);
		}
		else if(pid == 0 && i == 2)
		{
      int iterativeinput, iterativeanswer = 0;
      double start_i, stop_i, executiontime_i;
      read(iterative[0], &iterativeinput, sizeof(int));
      GET_TIME(start_i);
      iterativeanswer = fib_i(iterativeinput);
      GET_TIME(stop_i);
      executiontime_i = stop_i - start_i;
      cout << "Iterative Result: " << iterativeanswer << endl;
      write(iterativefinish[1], &executiontime_i, sizeof(double));
			exit(0);
		}
	}

  for(int i = 0; i < 3; i++)
  {
    pid = wait(&status);
    cout << "Child with pid " << pid << " exited, status=" << status << endl;
  }
}