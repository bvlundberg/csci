package main
import "fmt"

func convert(measure float64) (float64){
	return measure * .3048
}
func main(){
	x := 100.0
	x = convert(x)
	fmt.Println(x)
}