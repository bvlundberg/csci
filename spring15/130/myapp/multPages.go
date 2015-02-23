package pages

import (
        "net/http"
        "fmt"
)

func init() {
	http.HandleFunc("/", rootHandler)		
	http.HandleFunc("/brandon", myPage)
	http.HandleFunc("/dodgers", lad)
	http.HandleFunc("/giants", sf)
	http.ListenAndServe(":8080", nil)
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello!")
}

func myPage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "This is my page!")
}

func lad(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Home of your Los Angeles Dodgers!")
}

func sf(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Boooo!")
}
