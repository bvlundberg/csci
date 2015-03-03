package main

import ("fmt")

func maxint(x ...int) int {
	m := x[0]
	for _,j := range x {
		if j > m {
			m = j
		}
	}
	return m
}