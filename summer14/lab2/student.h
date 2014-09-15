// Lab2 Header File

/*
Author: Brandon Lundberg
File Name: student.h
Purpose: Class declaration for Student
Date: 17 June 2014
*/
#include "course.h"
#ifndef STUDENT_H
#define STUDENT_H

class Student
{
public:
	//Constructors
    Student(){
    	studentName = "blank";
    	departmentName = "undeclared";
    	score = 0;
        averageScore = 0;
    	gpa = 0;
        credits = 0;
    };
    Student(string);
    //mutators
    void setName(string);
    void setScores(double);
    void setCredits(double creds){
        credits += creds;
    }
    void setDepartmentName(string name){
        departmentName = name;
    }
    //Accessors
    double getScore(){
    	return score;
    }
    double getCredits(){
        return credits;
    }
    //Print
    void printStudent(){
    	cout << studentName << endl;
    	cout << departmentName << endl;
    	cout << score << endl;
        cout << averageScore << endl;
    	cout << gpa << endl;
    }
    //Calculations
    void getWeighedAverageScore(double x, Course newCourse){
            averageScore += (x * newCourse.getCredit()) / getCredits();
        }
    double getGPA();
private:
    string studentName;
    string departmentName;
    double score;
    double averageScore;
    double gpa;
    double credits;
    //vector <Course> courselist;
 };

 Student::Student(string newName){
    	studentName = newName;
    }
void Student::setName(string name){
	studentName = name;
}
void Student::setScores(double x){
	score = x;
}

#endif // !STUDENT_H