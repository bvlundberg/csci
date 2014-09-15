#	Author: Brando Lundberg
#	File Name: stairs.py
#	Purpose: python version of the recursive code stairs.cpp
#	Date: 25 August 2014

n = input("Enter the amount of steps: ")
list = []
def fib(n,list,step):
	list.append(step)
	if n == 0:
		for p in list:
			print p,
		print
		list = []
		return 1
	elif n < 0:
		return 0
	else:
		return fib(n-1,list,1) + fib(n-2,list,2) + fib(n-3,list,3)

print ("There are %d ways to the top") % fib(n,list,0)


