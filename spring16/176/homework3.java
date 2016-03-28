/*
    Author: Brandon Lundberg
    File Name: homework3.java
    Purpose: Matrix Multiplication using Java threads
    Date: 29 March 2016
*/

/*
    Global Documentation:
      To Run the project, you will need to run the following commands:
      >> javac homework3.java
      >> java homework3
*/

public class homework3
{
   //// create a shared_object in class global;
   //// create a shared_object in class communication;
   public static void main(String args[])
   {
     //// matrix A,B,C memory allocation here;
     //// matrix A,B initialization here;
     for (int k=0; k<4; k++)
     {
       mythread temp = new mythread(k, glob, comm); //pass thread_id & shared_objs
       temp.start();
     }
   }
}
  class globals //shared_obj for keeping matrix A,B,C
  {
     public int[][] A; //A matrix declare
     public int[][] B; //B matrix declare
     public int[][] C; //C matrix declare
  }
  class communication //shared_obj for communication/synchronization
  {
     private static int counter = 0;
     public synchronized void increment(int id) //mutex
     {
       counter++;
       //// if Thread_1
       //// check for wait() condition
       //// else
       //// check for notify() condition
     }
}

class mythread extends Thread
{
   static globals glob; //local for shared_obj
   static communication comm; //local for shared_obj
   private int id;
   public mythread(int k, globals glob, communication comm) //constructor
   {
     //// assign parameters to locals here;
   }
   public void run()
   {
     //// here matrix computation
     //// start/end index computation based on id

     //// increment done_counter in shared_obj comm;
     //// when all threads are done, display resulting C matrix in Thread_1
   }
}