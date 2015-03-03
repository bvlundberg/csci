package main
import "fmt"

func fib(x int) (int){
	if(x == 0){
		return 1
	} else if(x == 1){
		return 1
	} else{
		fib(x-1) + fib(x-2)
	}
}
func main(){
	x := 4
	fmt.Println(fib(x))
}