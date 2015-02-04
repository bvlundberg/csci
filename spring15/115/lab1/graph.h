class graph //class for the graph data structure
{
    public:  
    graph(){}
    graph(graph *prev, graph *next, int edge){
        m_prev = prev;
        m_next = next;
        m_edge = edge;
    }
    graph(graph *prev, graph *next, graph *head, int edge){
        m_prev = prev;
        m_next = next;
        m_head = head;
        m_edge = edge;
    }
     void initialize_graph(int num_of_vertices, int num_of_edges); //creates a new directed graph
     void insert_edge(int vertex1, int vertex2);  // inserts a directed edge (V1 - > V2) into the graph
     void delete_edge(int vertex1, int vertex2);    // deletes an edge (V1 -> V2) from the graph
     void list_all_edges(int num_of_vertices); // lists all of the edges in the graph
     void list_all_neighbors(int vertex1, int num_of_vertices); // lists all of the neighbors for a particular vertex
     void no_incoming_edges(int num_of_vertices);  // lists all of the vertices with no incoming edges
     bool no_incoming_edges_helper(int targetVertex, int currentList);

    private: 
    graph *m_prev; //pointer to the previous node in the linked list (used in the adjacency list implementation only)
    graph *m_next;  //pointer to the next node in the linked list    (used in the adjacency list implementation only)
    graph *m_head; //pointer to the head of a linked list            (used in the adjacency list implementation only)
    int m_edge;   // the id of the vertex that there is an edge to    (used in both implementations)
    
};
