class graph //class for the graph data structure
{
    public:  
     void initialize_graph(int num_of_vertices, int num_of_edges); //creates a new directed graph
     void insert_edge(int vertex1, int vertex2);  // inserts a directed edge (V1 - > V2) into the graph
     void delete_edge(int vertex1, int vertex2);    // deletes an edge (V1 -> V2) from the graph
     void list_all_edges(int num_of_vertices); // lists all of the edges in the graph
     void list_all_neighbors(int vertex1, int num_of_vertices); // lists all of the neighbors for a particular vertex
     void no_incoming_edges(int num_of_vertices);  // lists all of the vertices with no incoming edges
      
    private: 
    graph *prev; //pointer to the previous node in the linked list (used in the adjacency list implementation only)
    graph *next;  //pointer to the next node in the linked list    (used in the adjacency list implementation only)
    graph *head; //pointer to the head of a linked list            (used in the adjacency list implementation only)
    int edge;   // the id of the vertex that there is an edge to    (used in both implementations)
    
};
