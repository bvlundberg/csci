package main
import "fmt"

func smallest(array[] int) (int){
	temp := array[0]
	for _,x := range array {
		if x < temp{
			temp = x
		}
	}
	return temp
}
func main(){
	array := []int{ 48,96,86,68, 57,82,63,70, 37,34,83,27, 19,97, 9,17, }
	fmt.Println(smallest(array))
}