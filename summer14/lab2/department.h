// Lab2 Header File

/*
Author: Brandon Lundberg
File Name: department.h
Purpose: Class declaration for Department
Date: 17 June 2014
*/

#ifndef DEPARTMENT_H
#define DEPARTMENT_H

class Department
{
public:
    // Default Constructor
    Department(){
    	departmentName = "blank";
    	averageGPA = 0;
    	courseAverage = 0;
    	numberOfStudents = 0;
    };

    // Overloaded Constructor
    Department(string name){
        departmentName = name;
    };

    void enrollStudent(Student &newStudent){
    	//studentlist += name;
         newStudent.setDepartmentName(departmentName);
         studentlist.push_back(newStudent);
    };
    
    double getAverageGPA();
    void printGPA(){
        
    };
    void printCourseAverage();
private:
    string departmentName;
    double averageGPA;
    double courseAverage;
    int numberOfStudents;
    vector <Student> studentlist;
 };
#endif // !DEPARTMENT_H