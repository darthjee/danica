module Danica
  class Function::Baskara < Function
    variables :a, :b, :c

    private

    def function_block
      @function_block ||= numerator / denominator
    end

    def numerator
       Negative.new(b) + PositiveNegative.new(SquaredRoot.new(delta))
    end

    def denominator
      Number.new(2) * a
    end

    def delta
      Power.new(b, 2) - Product.new(4, a, c)
    end
  end
end

