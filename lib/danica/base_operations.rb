module Danica
  module BaseOperations
    def +(other)
      return other + self if other.is_a?(Operator::Sum)
      sum(self, other)
    end

    def *(other)
      return other * self if other.is_a?(Operator::Product)
      product(self, other)
    end

    def /(other)
      division(self, other)
    end

    def -(other)
      self + negative(other)
    end
  end
end
