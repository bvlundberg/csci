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

public class Homework3
{
   //// create a shared_object in class global;
   static globals glob = new globals();
   //// create a shared_object in class communication;
   static communication comm = new communication();
   public static void main(String args[])
   {
     glob.l = 100;
     glob.m = 100;
     glob.n = 100;
     glob.numThreads = 4;
     //// matrix A,B,C memory allocation here;
     glob.A = new int[glob.l][glob.m];
     glob.B = new int[glob.m][glob.n];
     glob.C = new int[glob.l][glob.n];
     //// matrix A,B initialization here;
     for(int i = 0; i < glob.l; i++)
        for(int j = 0; j < glob.m; j++)
            glob.A[i][j] = (i + j);

      for(int i = 0; i < glob.m; i++)
        for(int j = 0; j < glob.n; j++)
          glob.B[i][j] = (i + j + 1);

      for(int i = 0; i < glob.l; i++)
        for(int j = 0; j < glob.n; j++)
          glob.C[i][j] = 0;
      
     for (int k=0; k < glob.numThreads; k++)
     {
       mythread temp = new mythread(k, glob, comm); //pass thread_id & shared_objs
       temp.start();
     }
   }
}
  class globals //shared_obj for keeping matrix A,B,C
  {
     public int l, m, n, numThreads;
     public int[][] A; //A matrix declare
     public int[][] B; //B matrix declare
     public int[][] C; //C matrix declare
  }
  class communication //shared_obj for communication/synchronization
  {
     private static int counter = 0;
     public synchronized void increment(int id, int numThreads) //mutex
     {
       counter++;
       if(id == 0 && counter != numThreads)
       {
           //// check for wait() condition
           try
           {
               wait();
           }
           catch(InterruptedException e)
           {
               System.out.println("Exception " + e.getMessage());
           }
       }
       else
       {
           //// check for notify() condition
           System.out.println("Done!");
           notify();
       }
     }
}

class mythread extends Thread
{
   static globals glob; //local for shared_obj
   static communication comm; //local for shared_obj
   private int id;
   private int numThreads;
   public mythread(int k, globals glob, communication comm) //constructor
   {
     this.id = id;
     this.glob = glob;
     this.comm = comm;
   }
   public void run()
   {
     //// here matrix computation
     //// start/end index computation based on id
     int thread_id = id; //rank is void* type, so can cast to (long) type only;
     // Calculate quotient and remainder
     int quotient = glob.l / glob.numThreads;
     int remainder = glob.l % glob.numThreads;
    
     // Find indexes for rows to be calculated by this thread
     int my_count, my_first_i, my_last_i;
     if(thread_id < remainder){
       my_count = quotient + 1;
       my_first_i = thread_id * my_count;
     }
     else{
       my_count = quotient;
       my_first_i = thread_id * my_count + remainder;
     }
     my_last_i = my_first_i + my_count - 1;
     
     // Print this threads start and stop indexes
     System.out.println("Thread " + thread_id + ": start row: " + my_first_i + " end row: " + my_last_i);
  

     // Calculate matrix multiplication value for each designated location
     for(int i = my_first_i; i <= my_last_i; i++){
        for(int j = 0; j < glob.n; j++){
        // Initialize sum
        int sum = 0;
        for(int k = 0; k < glob.m; k++){
            // Update sum for each position
            sum += glob.A[i][k] * glob.B[k][j];
        }

        glob.C[i][j] = sum;
        }
      }

     //// increment done_counter in shared_obj comm;
     comm.increment(id, glob.numThreads);
     //// when all threads are done, display resulting C matrix in Thread_1
     if(id == 0)
     {
        // Display results
        // Print first results
        System.out.println("First 20 * First 10: ");
        for(int i = 0; i < 20; i++){
            for(int j = 0; j < 10; j++){
                System.out.print(glob.C[i][j] + " ");
            }
            System.out.println();
        }
        System.out.println();

        // Print last results
        System.out.println("Last 20 * Last 10: ");
        for(int i = glob.l - 21; i < glob.l - 1; i++){
            for(int j = glob.n - 11; j < glob.n - 1; j++){
                System.out.print(glob.C[i][j] + " ");
            }
            System.out.println();
        }
     }
   }
}