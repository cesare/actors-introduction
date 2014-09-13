package main

import (
  "fmt"
  "os"
  "strconv"
)

func fib(n int64) int64 {
  switch n {
  case 1, 2:
    return 1
  default:
    return fib(n - 2) + fib(n - 1)
  }
}

func run(ch chan int64, n int64) {
  value := fib(n)
  ch <- value
}

func main() {
  n, err := strconv.ParseInt(os.Args[1], 10, 64)
  if err != nil {
    fmt.Println("Usage: go run fibch number")
    return
  }

  ch := make(chan int64)
  go run(ch, n)

  value := <-ch
  fmt.Println(value)
}

// ex.
// $ go run fibch.go 40
