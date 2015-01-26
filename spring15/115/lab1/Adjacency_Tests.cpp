#include "gtest/gtest.h"
#include <cstdlib>
#include <iostream>
#include <vector>
#include "graph.h"

using namespace std;

TEST(AdjListInstantion, AllocatingSize){
	vector<graph*> adj_list;
	// Create pointers for each adjacency list for all verticies
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	EXPECT_EQ(adj_list.size(), 5);
}

TEST(AdjListInstantion, InsertEdges){
	vector<graph*> adj_list;
	// Create pointers for each adjacency list for all verticies
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);

	// Create edges
	graph graph_obj;
    graph_obj.insert_edge(0,1);

}

int main(int argc, char* argv[]){
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
	//printf("Hello World!\n");
	//return 0;
}