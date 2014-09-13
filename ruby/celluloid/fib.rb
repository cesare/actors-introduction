require 'celluloid'

class Fibonacci
  include Celluloid

  attr_reader :n

  def initialize(n)
    @n = n
  end

  def value
    return @value if @value

    case n
    when 0, 1, 2
      1
    else
      @value = fib(n - 2).value + fib(n - 1).value
    end
  end

  private

  def fib(n)
    name = name_for n
    Actor[name] ||= Fibonacci.new(n)
  end

  def name_for(n)
    "fib_#{n}".to_sym
  end
end
