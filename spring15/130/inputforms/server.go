package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"io/ioutil"
)

func init() {
	http.HandleFunc("/", root)
	http.HandleFunc("/results", showResults)
	fmt.Println("listening...")
	err := http.ListenAndServe(GetPort(), nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
		return
	}
}

func root(w http.ResponseWriter, r *http.Request) {
	index, err := ioutil.ReadFile("public/index.html");
	if err != nil {
		fmt.Fprint(w, "404 Not Found")
	}
	fmt.Fprint(w, string(index))
}

var results, _ = ioutil.ReadFile("public/results.html");
var resultsTemplate = template.Must(template.New("results").Parse(string(results)))

func showResults(w http.ResponseWriter, r *http.Request) {
	strEntered := r.FormValue("password")
	if strEntered == "Brandon" {

		err := resultsTemplate.Execute(w, "Ya Buddy")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	} else {
		err := resultsTemplate.Execute(w, "Eh...")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

// Get the Port from the environment so we can run on Heroku
func GetPort() string {
	var port = os.Getenv("PORT")
	// Set a default port if there is nothing in the environment
	if port == "" {
		port = ":8081"
		fmt.Println("INFO: No PORT environment variable detected, defaulting to " + port)
	}
	return port
}