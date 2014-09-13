class Fib1
  include Celluloid

  def fib(n)
    case n
    when 1, 2
      1
    else
      fib(n - 2) + fib(n - 1)
    end
  end
end
