defmodule FibServer do
  def start do
    pid = spawn __MODULE__, :loop, []
    :global.register_name :fib_server, pid
  end

  def loop do
    receive do
      {:fib, sender, n} ->
        IO.puts "received message: #{n}"
        send sender, {:ok, fib(n)}
    end

    loop
  end

  def fib(1), do: 1
  def fib(2), do: 1
  def fib(n) do
    fib(n - 2) + fib(n - 1)
  end
end

# ex.
# $ iex --sname foo
# $ iex --sname bar
#
# Node.list  # => []
#
# Node.connect :"bar@localhost"
# Node.list  # => [:"bar@localhost"]
#
# FibServer.start
# FibClient.fib(30)
#
