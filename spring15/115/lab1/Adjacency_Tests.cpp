#include "gtest/gtest.h"
#include <cstdlib>
#include <vector>
#include "graph.h"

using namespace std;

TEST(AdjList, Instantiation){
	vector<graph*> adj_list;
	// Create pointers for each adjacency list for all verticies
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	adj_list.push_back(NULL);
	EXPECT_EQ(adj_list.size(), 5);

	// Create edges




}

int main(int argc, char* argv[]){
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
	//printf("Hello World!\n");
	//return 0;
}