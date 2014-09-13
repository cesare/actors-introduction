class Fib2
  include Celluloid

  def fib(n)
    puts _fib(n)
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
