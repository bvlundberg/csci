#include "gtest/gtest.h"
#include "Node.h"
#include "BST.h"

TEST(Node, Instantiation){
	Node* testNode = new Node(7);
	EXPECT_EQ(testNode->getValue(), 7);
	EXPECT_FALSE(testNode->getrChild() != NULL && testNode->getlChild() != NULL);
}

TEST(BST, Instantiation){
	BST *testBST = new BST();
	Node *testNode = new Node();

	EXPECT_TRUE(testBST->getRoot() == NULL);
	EXPECT_TRUE(testBST->getNumNodes() == 0);

}

TEST(BST, InsertNodes){
	BST *testBST = new BST();

	testBST->insert_node(5);
	testBST->insert_node(3);
	testBST->insert_node(7);

	Node *root = testBST->getRoot();
	EXPECT_TRUE(root->getValue() == 5);
	EXPECT_TRUE(root->getlChild()->getValue() == 3);
	EXPECT_TRUE(root->getrChild()->getValue() == 7);
	EXPECT_TRUE(testBST->getNumNodes() == 3);
}

TEST(BST, FindNodes){
	BST *testBST = new BST();

	testBST->insert_node(5);
	testBST->insert_node(3);
	testBST->insert_node(7);
	testBST->insert_node(4);
	testBST->insert_node(9);

	EXPECT_TRUE(testBST->find_node(4));
	EXPECT_TRUE(testBST->find_node(9));
	EXPECT_FALSE(testBST->find_node(1));
	EXPECT_FALSE(testBST->find_node(6));
	EXPECT_TRUE(testBST->getNumNodes() == 5);
}

TEST(BST, DeleteNodes){
	BST *testBST = new BST();

	testBST->insert_node(5);
	testBST->insert_node(3);
	testBST->insert_node(7);
	testBST->insert_node(4);
	testBST->insert_node(9);

	testBST->traverse_inOrder(testBST->getRoot());
	printf("\n");

	EXPECT_TRUE(testBST->delete_node(9));
	EXPECT_TRUE(testBST->delete_node(5));
	EXPECT_FALSE(testBST->delete_node(6));
	EXPECT_TRUE(testBST->getNumNodes() == 3);

	testBST->traverse_inOrder(testBST->getRoot());
}
int main(int argc, char* argv[]){
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
	//printf("Hello World!\n");
	//return 0;
}