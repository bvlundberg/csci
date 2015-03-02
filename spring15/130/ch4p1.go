package main
import "fmt"

func convert(temp int) (int){
	temp -= 32
	temp *= 5
	temp /= 9
	return temp
}
func main(){
	x := 212
	x = convert(x)
	fmt.Println(x)
}