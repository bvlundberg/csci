#include <unistd.h>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>

using namespace std;

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
      int controllerinput, recursiveresult, iterativeresult;
      read(controller[0], &controllerinput, sizeof(int));
      write(recursive[1], &controllerinput, sizeof(int));
      write(iterative[1], &controllerinput, sizeof(int));
      read(recursivefinish[0], &recursiveresult, sizeof(int));
      read(iterativefinish[0], &iterativeresult, sizeof(int));

      cout << "Recursive result: " << recursiveresult << endl;
      cout << "Iterative result: " << iterativeresult << endl;
			exit(0);
		}
		else if(pid == 0 && i == 1)
		{
      int recursiveinput, recursiveanswer = 0;
      read(recursive[0], &recursiveinput, sizeof(int));
      recursiveanswer = fib_r(recursiveinput);
      write(recursivefinish[1], &recursiveanswer, sizeof(int));
			exit(0);
		}
		else if(pid == 0 && i == 2)
		{
      int iterativeinput, iterativeanswer = 0;
      read(iterative[0], &iterativeinput, sizeof(int));
      iterativeanswer = fib_i(iterativeinput);
      write(iterativefinish[1], &iterativeanswer, sizeof(int));
			exit(0);
		}
	}
}