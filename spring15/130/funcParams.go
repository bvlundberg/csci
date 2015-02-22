package main
import "fmt"

type MapFunc func(int) (int)
type ReturnFunc func() (int)

func incAll(x []int, map MapFunc) ([]int) {
	newX := make([]int, len(x))
	for i := 0; i < len(x); i++{
		newX[i] = map(x[i])
	}
	return newX
}

func dec(x int) (ReturnFunc) {
	return func() (int) {
		return x--
	}
}


func main(){  
	var array []int = {1,2,3,4,5}
	var function = func(x int) (int) {return x++}
	var mappedArray []int = incAll(array, function)
	fmt.Println(array)
	fmt.Println(mappedArray)

	function2 := dec(array[1])
	fmt.Println(function2())
}