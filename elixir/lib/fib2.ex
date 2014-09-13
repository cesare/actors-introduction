defmodule Fib2 do
  def fib(n) do
    IO.puts "Fib2.fib #{n} start"
    worker = spawn __MODULE__, :fibonacci, [n, self]

    IO.puts "Fib2.fib waiting for reply"
    receive do
      {:ok, value} -> IO.puts "Received: #{value}"
    end
  end

  def fibonacci(n, parent) do
    IO.puts "Fib2.fibonacci start"

    send parent, {:ok, calc(n)}

    IO.puts "Fib2.fibonacci end"
  end

  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n) do
    calc(n - 2) + calc(n - 1)
  end
end

#
# ex.
# Fib2.fib(40)
#
