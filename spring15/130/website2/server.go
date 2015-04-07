package hello

import (
	"html/template"
	"io/ioutil"
	"net/http"
	"appengine"
    "appengine/user"
    "fmt"
)

var (
	guestbookForm []byte
	signTemplate  = template.Must(template.ParseFiles("public/guestbook.html"))
)

func init() {
	content, err := ioutil.ReadFile("public/guestbookform.html")
	if err != nil {
		panic(err)
	}
	guestbookForm = content

	http.HandleFunc("/", root)
	http.HandleFunc("/sign", sign)
}

func root(w http.ResponseWriter, r *http.Request) { w.Write(guestbookForm) }

func sign(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-type", "text/html; charset=utf-8")
    c := appengine.NewContext(r)
    u := user.Current(c)
    if u == nil {
        url, _ := user.LoginURL(c, "/")
        fmt.Fprintf(w, `<a href="%s">Sign in or register</a>`, url)
        return
    }
    url, _ := user.LogoutURL(c, "/")
    fmt.Fprintf(w, `Welcome, %s! (<a href="%s">sign out</a>)`, u, url)
}