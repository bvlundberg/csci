package main
import "fmt"

func half(x int) (bool){
	x /= 2
	if(x % 2 == 0){
		return true;
	} else{
		return false;
	}
}
func main(){
	x := 28
	ans := half(x)
	if(ans){
		fmt.Println("True")
	} else{
		fmt.Println("False")
	}
}