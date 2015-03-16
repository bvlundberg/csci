package main

import "text/template"
import "os"

type Client struct {
	Honorific string
	Name string
	Attended bool
	Donated bool
	Events []string
	DateJoined string
}


func main(){
	var events = []string{"Meet the Giants Dinner - January 18 2016", "Opening Day at COS - February 10 2016", "Easter Classic Tournament at Fresno City College - April 4 2016"}
	var clients = []Client{
						{"Mrs.", "Towle", true, true,  events, "Decemeber 2011"},
						{"Mr.", "Lundberg", true, false, events, "January 2012"},
						{"Ms.", "Black", false, true, events, "July 2014"},
						{"Mrs.", "Marsh", false, false, events, "September 2000"},
	}

	mail := `Dear {{.Honorific}} {{.Name}},
	Since {{.DateJoined}} you have been supporting the COS Giants. The Giants are extremely grateful for your support and want to thank you for allowing us to continue supporting our players and community year after year.{{if .Attended}} We hope you enjoyed our annual golf tournament and look forward to seeing you tee up again next year! {{else}} We missed you at the annual golf tournament this year! We hope to see you next year. {{end}} This years tournament raised over $10,000, which will go towards the players education and livelyhood here at COS.
	{{if .Donated}} We want to thank you again for your generous donation. It is people like you who allow students to pursue their dreams of playing college baseball and receiving a quality education.{{end}}
There are a few events coming up we would like to inform you on: 
{{range .Events}}	{{.}}
{{end}}
We hope to see you soon!
Sincerely,
Brandon Lundberg

`
	tmpl, _ := template.New("mailTemplate").Parse(mail)
	for _,thisClient := range clients {	
		tmpl.Execute(os.Stdout, thisClient)
	}
	
}
