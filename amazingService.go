package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		select {
		case <-time.After(6 * time.Second):
			fmt.Println("My Amazing Service is up!")
		}
	}
}
