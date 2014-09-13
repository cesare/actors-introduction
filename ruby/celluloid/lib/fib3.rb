class Fib3
  include Celluloid

  def fib(n, receiver)
    receiver.mailbox << _fib(n)
  end

  private

  def _fib(n)
    case n
    when 1, 2
      1
    else
      _fib(n - 2) + _fib(n - 1)
    end
  end
end

class Receiver
  include Celluloid

  def wait
    puts 'Start Receiver#wait'

    loop do
      message = receive { |msg| msg.is_a? Fixnum }
      puts "Receiver#wait received message: #{message}"
    end
  end
end
