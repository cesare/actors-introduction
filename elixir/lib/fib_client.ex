defmodule FibClient do
  def fib(n) do
    pid = :global.whereis_name :fib_server
    send pid, {:fib, self, n}
    wait
  end

  def wait do
    receive do
      {:ok, value} -> IO.puts "Receive: #{value}"
    end
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
