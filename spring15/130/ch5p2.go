package main
import "fmt"

func fizzbuzz(){
	for x := 1; x <= 100; x++{
		if(x % 3 == 0){
			if(x % 5 == 0){
				fmt.Println("FizzBuzz")
			} else{
				fmt.Println("Fizz")
			}
		} else if(x % 5 == 0){
			fmt.Println("Buzz")
		} else{
			fmt.Println(x)
		}
		
	}
}
func main(){
	fizzbuzz()
}