package main
import "fmt"

func main(){
	const LENGTH = 5
	drinkingAge := 21

	// Work with pointers on addresses and values
	var agePointer *int = &drinkingAge
	fmt.Printf("The drinking age in the US is %v \n", *agePointer)
	fmt.Printf("The memory location that holds the drinking age in the US is stored in address %v \n" , agePointer)
	fmt.Printf("Change the drinking age! \n")
	*agePointer = 18
	fmt.Printf("The drinking age is now %d \n", *agePointer)
	fmt.Printf("You can do better than that! Change it again!\n")
	*agePointer = 16
	fmt.Printf("The drinking age is %v! Now save this address so you can change it again later: %v \n", *agePointer, agePointer)

	// Declare a list to be sorted
	var list [LENGTH] int
	for i,j := 5,0; i > 0; i,j = i-1,j+1 {
		list[j] = i
	}
	fmt.Println(list)

	var pointer1 *int = &list[0]
	var pointer2 *int = &list[1]
	var pointer3 *int = &list[2]
	var pointer4 *int = &list[3]
	var pointer5 *int = &list[4]

	// List of pointers to the previous array
	var listPointers [LENGTH] *int
	listPointers[0] = pointer1
	listPointers[1] = pointer2
	listPointers[2] = pointer3
	listPointers[3] = pointer4
	listPointers[4] = pointer5

	// Cycyle through the pointer list to get the elements in the value list
	var doublePointer **int
	for i := 0; i < LENGTH; i++ {
		doublePointer = &listPointers[i]
		fmt.Printf("%d", **doublePointer)
	}

}