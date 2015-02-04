#include <cstdlib>
#include <iostream>
#include <vector>
#include "graph.h"

using namespace std;

vector< vector<graph> > adj_matrix; //two dimensional vector to represent the adjacency matrix

void graph::initialize_graph(int num_of_vertices, int num_of_edges)
{
    int vertex1, vertex2;
    graph newGraph;

    vector <graph> matrix_row;
    graph graph_obj;
    for(int i = 0; i < num_of_vertices; i++){
        matrix_row.push_back(graph_obj);
    }    
    for(int i = 0; i < num_of_vertices; i++){
        adj_matrix.push_back(matrix_row);
    }

    for(int i = 0; i < num_of_vertices; i++){
        for(int j = 0; j < num_of_vertices; j++){
            adj_matrix[i][j].m_edge = 0;
        }
    }

    for(int i = 0; i < num_of_edges; i++){
        cout<<"To enter an edge X -> Y (an edge from node X to node Y), use the following format: X Y (the names of the two vertices separated by a single space)" << endl;
        cout<<"Enter the edge to insert into the graph: ";
        cin>>vertex1>>vertex2;
        cout<<endl<<endl;
        newGraph.insert_edge(vertex1, vertex2); 
    }
    cout<<endl<<endl<<endl;
    
}

void graph::insert_edge(int vertex1, int vertex2)
{
    adj_matrix[vertex1][vertex2].m_edge = 1;
 
 cout<<endl<<endl<<endl;
  
}

void graph::delete_edge(int vertex1, int vertex2)
{
  
    adj_matrix[vertex1][vertex2].m_edge = 0;
  
 cout<<endl<<endl<<endl;

}

void graph::list_all_edges(int num_of_vertices)
{
   for(int i = 0; i < num_of_vertices; i++){
        for(int j = 0; j < num_of_vertices; j++){
            if(adj_matrix[i][j].m_edge == 1)
                cout << i << "->" << j << endl;
        }
    }
   cout<<endl<<endl<<endl;
}

void graph::list_all_neighbors(int vertex1, int num_of_vertices)
{  
    for(int i = 0; i < num_of_vertices; i++){
        if(adj_matrix[vertex1][i].m_edge == 1)
            cout << i << " ";
    }
   cout<<endl<<endl<<endl;
}

void graph::no_incoming_edges(int num_of_vertices)
{
    for(int i = 0; i < num_of_vertices; i++){
        bool noEdges = true;
        for(int j = 0; j < num_of_vertices; j++){
            if(adj_matrix[j][i].m_edge == 1)
                noEdges = false;
        }
        if(noEdges)
            cout << i << " ";
    }
    cout<<endl<<endl<<endl;
}



int main()
{
    int num_of_vertices, num_of_edges, vertex1, vertex2, function;
    graph graph_obj;
    
    
    while(1)
    {
    
     cout<<"1 - initialize graph" <<endl;
     cout<<"2 - insert an edge to the graph" <<endl;
     cout<<"3 - delete an edge from the graph" <<endl;
     cout<<"4 - list all edges in the graph" <<endl;
     cout<<"5 - list all of the neighbors for a particular vertex" << endl;
     cout<<"6 - list all of the vertices with no incoming edges" << endl << endl;
    
    cout<<"Choose a function (1 - 6): ";
    cin>>function;
    cout<<endl<<endl;
    
    switch(function)
    {
      case 1: 
             cout<<"Enter the number of vertices in the graph: ";
             cin>>num_of_vertices;
             cout<<endl<<"Enter the number of edges in the graph: ";
             cin>>num_of_edges;
             cout<<endl<<endl;
             graph_obj.initialize_graph(num_of_vertices, num_of_edges);
             break;
     
     case 2: 
            cout<<"To enter an edge X -> Y (an edge from node X to node Y), use the following format: X Y (the names of the two vertices separated by a single space)" << endl;
            cout<<"Enter the edge to insert into the graph: ";
            cin>>vertex1>>vertex2;
           cout<<endl<<endl;
           graph_obj.insert_edge(vertex1, vertex2);         
           break;
     
     case 3: 
            cout<<"To enter an edge X -> Y (an edge from node X to node Y), use the following format: X Y (the names of the two vertices separated by a single space)" << endl;
            cout<<"Enter the edge to delete from the graph: ";
            cin>>vertex1>>vertex2;
            cout<<endl<<endl;
           graph_obj.delete_edge(vertex1, vertex2);         
           break;
   
     case 4:
             graph_obj.list_all_edges(num_of_vertices);
             break;
     
     case 5:   
            cout<<"Enter the vertex to list all of the neighbors for: ";
            cin>>vertex1;
            cout<<endl<<endl;
            graph_obj.list_all_neighbors(vertex1, num_of_vertices);
            break;
            
     case 6:
           graph_obj.no_incoming_edges(num_of_vertices);
            
              
    } //end switch
    
     
    
    }  //end while
    
    system("PAUSE");
    return 0;
}
