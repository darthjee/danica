module Danica
  module BaseOperations
    def +(other)
      return other + self if other.is_a?(Sum)
      Sum.new(self, other)
    end

    def *(other)
      return other * self if other.is_a?(Product)
      Product.new(self, other)
    end

    def /(other)
      Division.new(self, other)
    end
  end
end
