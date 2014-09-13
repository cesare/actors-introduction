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

func main() {
  n, err := strconv.ParseInt(os.Args[1], 10, 64)
  if err != nil {
    fmt.Println("Usage: go run fib.go number")
    return
  }

  value := fib(n)
  fmt.Println(value)
}

// ex.
// $ go run fib.go 10
