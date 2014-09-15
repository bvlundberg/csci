// Lab2 Header File

/*
Author: Brandon Lundberg
File Name: course.h
Purpose: Class declaration for Course
Date: 17 June 2014
*/

#ifndef COURSE_H
#define COURSE_H

class Course
{
public:
    Course(){
    	courseName = "blank";
        //enrolled = false;
    	credit = 0;
    }
    Course(string name, double cred){
    	courseName = name;
    	credit = cred;
    }
    double getCredit(){
    	return credit;
    }
    void printCourse(){
    	cout << courseName << endl;
    	cout << credit << endl;
    }
private:
    string courseName;
    double credit;
    //double courseAverage;
    //int numStudents;
};
#endif // !COURSE_H2