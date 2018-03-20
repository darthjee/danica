module Danica
  module BaseOperations
    def +(other)
      value = addition(self, other)
      return other.repack(value) if other.is_a?(Danica::Formatted)
      value
    end

    def *(other)
      value = multiplication(self, other)
      return other.repack(value) if other.is_a?(Danica::Formatted)
      value
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
      negative(self)
    end
  end
end
