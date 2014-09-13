defmodule Receiver do
  def start do
    spawn __MODULE__, :loop, []
  end

  def loop do
    receive do
      {:ok, message} -> IO.puts "Receiver#loop received message: #{message}"
    end

    loop
  end
end


#
# recv = Receiver.start  # => PID
#
