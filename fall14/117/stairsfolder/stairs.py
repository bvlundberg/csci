#	Author: Brando Lundberg
#	File Name: stairs.py
#	Purpose: python version of the recursive code stairs.cpp
#	Date: 25 August 2014

n = input("Enter the amount of steps: ")
def fib(n):
	if n == 0:
		return 1
	elif n < 0:
		return 0
	else:
		return fib(n-1) + fib(n-2)

print ("There are %d ways to the top") % fib(n)


