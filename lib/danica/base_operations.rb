module Danica
  module BaseOperations
    def +(other)
      return other + self if other.is_a?(Operator::Addition)
      addition(self, other)
    end

    def *(other)
      return other * self if other.is_a?(Operator::Multiplication)
      multiplication(self, other)
    end

    def /(other)
      division(self, other)
    end

    def -(other)
      self + negative(other)
    end

    def **(other)
      power(self, other)
    end

    def -@
      Wrapper::Negative.new(self)
    end
  end
end
