defmodule Fib do
  def start do
    spawn __MODULE__, :loop, []
  end

  def loop do
    receive do
      {:fib, sender, n} -> send sender, {:ok, fib(n)}
    end

    loop
  end

  def fib(1), do: 1
  def fib(2), do: 1
  def fib(n) do
    fib(n - 2) + fib(n - 1)
  end
end


#
# ex.1
#
# fib = Fib.start  # => PID
# send fib, {:fib, self, 40}
#
# receive do
#   {:ok, n} -> IO.puts "Received: #{n}"
# end
#
#
# ex.2
#
# recv = Receiver.start
# send fib, {:fib, recv, 40}
#
