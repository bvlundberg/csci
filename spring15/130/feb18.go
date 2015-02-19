package main

import ("fmt")

type Person struct{
	Fname string
	Lname string
}

func main() {
	
	//Map
	var lName map[string]string
	lName = make(map[string]string)
	
	lName["Billy"] = "Bob"
	lName["Ray"] = "Johnson"
	
	var billy = "Billy"
	var ray = "Ray"
	
	getLastName(lName, billy)
	getLastName(lName, ray)

	//Slices
	teams := []string{"Dodgers", "Giants", "Padres", "Rockies"}
	for _,team := range teams {
		fmt.Println(team)
	}

	//Slice a string
	me := "Brandon"
	slice := me[3:7]
	fmt.Print(slice)
	
}

func getLastName(lName map[string]string, person string) {
	fmt.Printf("%s last name is %s\n", person, lName[person])
}