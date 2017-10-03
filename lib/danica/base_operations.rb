module Danica
  module BaseOperations
    def +(other)
      return other + self if other.is_a?(Operator::Sum)
      Operator::Sum.new(self, other)
    end

    def *(other)
      return other * self if other.is_a?(Operator::Product)
      Operator::Product.new(self, other)
    end

    def /(other)
      Operator::Division.new(self, other)
    end

    def -(other)
      self + Wrapper::Negative.new(other)
    end
  end
end
