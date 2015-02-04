#include "gtest/gtest.h"
#include "graph.h"

TEST(AdjList, Instantiation){
	Node* testNode = new Node(7);
	EXPECT_EQ(testNode->getValue(), 7);
	EXPECT_FALSE(testNode->getrChild() != NULL && testNode->getlChild() != NULL);
}

int main(int argc, char* argv[]){
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
	//printf("Hello World!\n");
	//return 0;
}