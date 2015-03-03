package main
import "fmt"

func swap(x *int, y *int){
	temp := *y
	*y = *x
	*x = temp
	return
}
func main(){
	x := 4
	y := 7
	swap(&x, &y)
	fmt.Println(x)
	fmt.Println(y)
}