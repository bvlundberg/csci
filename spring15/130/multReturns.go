package main
import "fmt"

func SquareCube(i,_ int) (int, int) {
    return i*i, i*i*i
}

func MyName()(string, string){
	return "Brandon", "Lundberg"
}
func main() { 
	var x int
	square, cube := SquareCube(3, x)
    fmt.Println("Square:", square, "| Product:",cube)
    fName, lName := MyName()
    fmt.Println("First Name:", fName, "| Last Name:", lName)
}