// Lab 2 Main.cpp

/*
Author: Brandon Lundberg
File Name: main.cpp
Purpose: Classes
Date: 18 June 2014
*/

#include <iostream>
using namespace std;

#include <string>
#include <vector>
#include "student.h"
#include "course.h"
#include "department.h"



int main(){
	// Create Department
	string temp;
	double temp2;
	cout << "Please enter name of the department: ";
	cin >> temp;
	Department d1 = Department(temp);
	// Set student records in courses
	cout << "Please enter a name of a course in this department, followed by the credit for the course: ";	
	cin >> temp >> temp2;
	Course c1 = Course(temp, temp2);
	c1.printCourse();
	// Create Student
	cout << "Enter the name of a student in this course: ";
	cin >> temp;
	Student s1 = Student(temp);
	s1.setCredits(temp2);
	// Enroll new student in department
	d1.enrollStudent(s1);
	//s1.printStudent();
	cout << "Enter student's score in the course: ";
	cin >> temp2;
	s1.setScores(temp2);
	s1.getWeighedAverageScore(temp2/100, c1);
	s1.printStudent();
	return 0;
}