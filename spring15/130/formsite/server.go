package main

import (
	"fmt"
	"html/template"
	"net/http"
	"os"
	"path"
	"strings"
)

func init() {
	http.HandleFunc("/", ServeTemplate)
}
func Static(w http.ResponseWriter, r *http.Request){
	http.ServeFile(w, r, "public/"+r.URL.Path)
}
func ServeTemplate(w http.ResponseWriter, r *http.Request) {
	if(strings.HasPrefix(r.URL.Path, "/templates/")){
		lp := path.Join("public", "layout.html") // templates/layout.html 					// http://golang.org/pkg/path/#Join
		fp := path.Join("templates", r.URL.Path)    // templates/r.URL.Path[1:]
		// Return a 404 if the template doesn't exist
		info, err := os.Stat(fp) // http://golang.org/pkg/os/#Stat
		if err != nil {
			if os.IsNotExist(err) { // http://golang.org/pkg/os/#IsNotExist
				http.NotFound(w, r) // http://golang.org/pkg/net/http/#NotFound
				return
			}
		}

		// Return a 404 if the request is for a directory
		if info.IsDir() { // http://golang.org/pkg/os/#FileMode.IsDir
			http.NotFound(w, r)
			return
		}

		// STEP 1: create a new template - looks like it's automatically created
		// STEP 2: parse the string into the template
		//  // in lay terms: "give the template your form letter"
		//  // in lay terms: "put your form letter into the template"
		// STEP 3: execute the template
		//  // merge template with data

		templates, _ := template.ParseFiles(lp, fp) // http://golang.org/pkg/html/template/#ParseFiles // http://golang.org/pkg/html/template/#Template.ParseFiles
		if err != nil {
			fmt.Println(err)
			http.Error(w, "500 Internal Server Error", 500)
			return
		}

		templates.ExecuteTemplate(w, "layout", nil) // http://golang.org/pkg/html/template/#Template.ExecuteTemplate
	}else{
		Static(w,r)
	}
	/*else if(r.URL.Path =="/"){
		http.Redirect(w, r, "index.html", 302)
	}
	*/
	
}