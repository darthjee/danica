module Danica
  module BaseOperations
    def +(other)
      formatted_operation other, addition(self, other)
    end

    def *(other)
      formatted_operation other, multiplication(self, other)
    end

    def /(other)
      formatted_operation other, division(self, other)
    end

    def -(other)
      formatted_operation other, (self + negative(other))
    end

    def **(other)
      formatted_operation other, power(self, other)
    end

    def -@
      negative(self)
    end

    private

    def formatted_operation(other, value)
      return other.repack(value) if other.is_a?(Danica::Formatted)
      value
    end
  end
end
