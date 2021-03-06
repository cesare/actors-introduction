defmodule Fib3Link do
  def run_random(n) do
    Process.flag :trap_exit, true  # <-

    Enum.map 1..n, fn(_) ->
      n = :random.uniform(10) - 1
      # spawn -> spawn_link
      spawn_link __MODULE__, :fibonacci, [n, self]

      IO.puts "Fib3Link.run_random: spawned worker with n = #{n}"
    end

    loop n
  end

  def loop(n) do
    if n > 0 do
      receive do
        {:ok, value} ->
          IO.puts "Receive: #{value}"
          loop(n)
        {:EXIT, pid, :normal} ->
          loop(n - 1)
        {:EXIT, pid, reason} ->
          IO.puts " * Process #{inspect(pid)} failed: #{inspect(reason)}"
          loop(n - 1)
      end
    end
  end

  def fibonacci(n, parent) do
    send parent, {:ok, calc(n)}
  end

  def calc(0), do: raise "n should be greater than zero"
  def calc(1), do: 1
  def calc(2), do: 1
  def calc(n) do
    calc(n - 2) + calc(n - 1)
  end
end

#
# ex.
# Fib3Link.run_random(10)
#
