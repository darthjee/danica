module Danica
  class Function::Baskara < Function
    variables :a, :b, :c

    private

    def function_block
      @function_block ||= numerator / denominator
    end

    def numerator
       negative(b) + PositiveNegative.new(squared_root(delta))
    end

    def denominator
      number(2) * a
    end

    def delta
      power(b, 2) - product(4, a, c)
    end
  end
end

