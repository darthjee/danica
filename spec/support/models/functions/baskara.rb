module Danica
  class Function::Baskara < Function.build(:a, :b, :c) { numerator / denominator }

    private

    def numerator
       negative(b) + Wrapper::PlusMinus.new(squared_root(delta))
    end

    def denominator
      number(2) * a
    end

    def delta
      power(b, 2) - multiplication(4, a, c)
    end
  end
end

