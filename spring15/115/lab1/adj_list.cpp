#include <cstdlib>
#include <iostream>
#include <vector>
#include "graph.h"
using namespace std;

vector<graph*> adj_list; // one dimensional vector; each position in the vector stores a pointer to the head of a linked list


void graph::initialize_graph(int num_of_vertices, int num_of_edges)
{
    int vertex1, vertex2;
    graph newGraph;
    for(int i = 0; i < num_of_vertices; i++){
        adj_list.push_back(NULL);
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
    if(adj_list[vertex1] == NULL){
        graph *newVertex = new graph(NULL, NULL, newVertex, vertex2);
        adj_list[vertex1] = newVertex;
    }
    else{
        graph *currVertex = adj_list[vertex1];
        // Traverse to the end of the linked list
        while(currVertex->m_next != NULL){
            // Vertex is already in the list
            if(currVertex->m_edge == vertex2)
                return;
            currVertex = currVertex->m_next;
        }
        graph *newVertex = new graph(currVertex, NULL, vertex2);
        currVertex->m_next = newVertex;
    }
    cout<<endl<<endl<<endl;
}

void graph::delete_edge(int vertex1, int vertex2)
{
    if(adj_list[vertex1] == NULL){
        cout << "No edges from this vertex.";
        return;
    }
    else{
        graph *currVertex = adj_list[vertex1];
        while(currVertex != NULL){
            // Edge found
            if(currVertex -> m_edge == vertex2){
                // If the currVertex is the head
                if(currVertex == adj_list[vertex1]){
                    currVertex->m_next->m_prev = NULL;
                    adj_list[vertex1] = currVertex->m_next;
                    currVertex = NULL;
                    delete currVertex; 
                }
                // Any other case
                else{
                    currVertex->m_prev->m_next = currVertex->m_next;
                    // If the current vertex next is null
                    if(currVertex->m_next != NULL){
                        currVertex->m_next->m_prev = currVertex->m_prev;
                    }
                    currVertex = NULL;
                    delete currVertex;
                }
            }
            else
                currVertex = currVertex -> m_next;
        }
        // Edge was not in the list
        cout << "This edge was not found.";
        return;
    }
    cout<<endl<<endl<<endl;
}

void graph::list_all_edges(int num_of_vertices)
{
    for(int i = 0; i < num_of_vertices; i++){
        graph *currNode = adj_list[i];
        while(currNode != NULL){
            cout << i << "->" << currNode->m_edge << endl;
            currNode = currNode->m_next;
        }
    }
    cout<<endl<<endl<<endl;
}

void graph::list_all_neighbors(int vertex1, int num_of_vertices)
{  
 
     //implement this function  
      
   cout<<endl<<endl<<endl;
}

void graph::no_incoming_edges(int num_of_vertices)
{
    for(int i = 0; i < num_of_vertices; i++){
        bool noEdges = true;
        for(int j = 0; j < num_of_vertices; j++){
            noEdges &= no_incoming_edges_helper(i, j);
        }
        if(noEdges)
            cout << i << " ";
    }
    cout<<endl<<endl<<endl;
}

bool graph::no_incoming_edges_helper(int targetVertex, int currList){
    graph *currNode = adj_list[currList];
    while(currNode != NULL){
        if(currNode->m_edge == targetVertex)
            return false;
        currNode = currNode->m_next;
    }
    return true;
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
            cout<<"To enter an edge X -> Y (an edge from node X to node Y), use the following fgraph_obj.ormat: X Y (the names of the two vertices separated by a single space)" << endl;
            cout<<"Enter the edge to delete from the graph: ";
            cin>>vertex1>>vertex2;
            cout<<endl<<endl;
           graph_obj.delete_edge(vertex1, vertex2);         
           break;
   
     case 4:
            cout << "Every edge in the graph: " << endl;
             graph_obj.list_all_edges(num_of_vertices);
             break;
     
     case 5:   
            cout<<"Enter the vertex to list all of the neighbors for: ";
            cin>>vertex1;
            cout<<endl<<endl;
            graph_obj.list_all_neighbors(vertex1, num_of_vertices);
            break;
            
     case 6:
            cout << "The following verticies have no incoming edges: ";
           graph_obj.no_incoming_edges(num_of_vertices);
            
              
    } //end switch
    
     
    
    }  //end while
    
    system("PAUSE");
    return 0;
}

