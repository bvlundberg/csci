
package main

import "fmt"

// TYPE
type mySentence string

// TYPES CAN CONTAIN METHODS
func (s mySentence) eatChocolate() {
	fmt.Println("METHOD: EAT MORE CHOCOLATE NOW")
	fmt.Println(s)
}

func (s mySentence) doubs() {
	s += s
	fmt.Println(s)
}

func main() {

	// TYPES CAN CONTAIN DATA
	var message mySentence = "Hello World!"
	fmt.Println("DATA: " + message)

	// TYPES CAN USE METHODS
	message.eatChocolate()
	message.doubs()
	fmt.Println(message)

}