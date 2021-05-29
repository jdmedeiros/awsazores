package main

import (
    "fmt"
    "math/rand"
    "time"
    "sort"
)

func main() {
    rand.Seed(time.Now().UnixNano())
    var numeros [5]int
    var estrelas [2]int

    i := 0
    p := rand.Perm(51)
    for _, r := range p[:5] {
        numeros[i] = r + 1
        i++
    }

    i = 0
    p = rand.Perm(12)
    for _, r := range p[:2] {
        estrelas[i] = r + 1
        i++
    }

    sort.Ints(numeros[:])
    sort.Ints(estrelas[:])

    fmt.Print(numeros)
    fmt.Print(" - ")
    fmt.Println(estrelas)
    fmt.Println("Boa sorte!")

}