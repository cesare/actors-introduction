package main

import (
  "fmt"
  "math/rand"
)

func fib(n int64) int64 {
  switch n {
  case 1, 2:
    return 1
  default:
    return fib(n - 2) + fib(n - 1)
  }
}

func run(ch chan int64) {
  n := rand.Int63n(30)
  value := fib(n)
  ch <- value
}

func wait(ch chan int64, n int) {
  for i := 0; i < n; i++ {
    value := <-ch
    fmt.Println(value)
  }
}

func main() {
  loopCount := 10

  ch := make(chan int64)

  go wait(ch, loopCount)

  for i := 0; i < loopCount; i++ {
    fmt.Printf("run #%d\n", i)
    go run(ch)
  }

  var input string
  fmt.Scanln(&input)
}
