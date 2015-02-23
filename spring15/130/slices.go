package main

import ("fmt")

type Player struct{
	position string;
	number int;
}

func (player Player) getPosition(){
	fmt.Println("This player plays ", player.position)
}

func removeFront(slice []string, index int) []string{
	return append(slice[:0], slice[index:]...)
	
}

func removeBack(slice []string, index int) []string{
	return append(slice[:0], slice[:(len(slice) - index)]...)
	
}

func main() {
	slice := []string{"Brandon", "Vincent"}
	fmt.Println(slice)
	slice = append(slice, "Lundberg")
	fmt.Println(slice)
	slice = removeFront(slice, 1)
	fmt.Println(slice)
	slice = removeBack(slice, 1)
	fmt.Println(slice)

	var newPlayer Player
	newPlayer.position = "Left Field"
	newPlayer.number = 33
	newPlayer.getPosition()



}
