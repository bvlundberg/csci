package main

import (
    "html/template"
    "net/http"
    "strconv"
    "time"
)

var posttemplate *template.Template

var posts [3]string

var templ = `<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
{{.}}
<br /><a href="/">&lt; Back</a>
</body>
</html>`

func init() {

    posts[0] = "Schedule"
    posts[1] = "Roster"
    posts[2] = "Stats"

    http.HandleFunc("/", handler)
    http.HandleFunc("/view", view)
    posttemplate = template.Must(template.New("templ").Parse(templ))
   
}

func handler(w http.ResponseWriter, r *http.Request) {
    
    expire := time.Now().AddDate(0, 0, 1)
    cookie, err := r.Cookie("NumPlayers")    
    num:=0
    if(err != nil){
        c := http.Cookie{
            Name:       "NumPlayers",
            Value:      "0",
            Expires:    expire,
            RawExpires: expire.Format(time.UnixDate),
            MaxAge:   86400,
            Secure:   false,
            HttpOnly: false,
        }
        http.SetCookie(w, &c)
    }else{
        num,_ = strconv.Atoi(cookie.Value)
        num += 1
        numstr := strconv.Itoa(num)
        c := http.Cookie{
            Name:       "NumPlayers",
            Value:      numstr,
            Expires:    expire,
            RawExpires: expire.Format(time.UnixDate),
            MaxAge:   86400,
            Secure:   false,
            HttpOnly: false,
        }
        http.SetCookie(w, &c)    
    }
    
    mytemp := template.Must(template.ParseFiles("index.html"))
    mytemp.ExecuteTemplate(w, "index.html", strconv.Itoa(num))
    
}

func view(w http.ResponseWriter, r *http.Request) {
    postid,err := strconv.Atoi(r.FormValue("postid"))
    
    if ( err != nil || postid >= len(posts) || postid < 0 ) {
        http.Error(w, "Invalid post ID", 500)
        return
    }
  
    err = posttemplate.ExecuteTemplate(w, "templ", posts[postid])
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
}