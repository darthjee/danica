module Danica
  module BaseOperations
    def +(other)
      addition(self, other)
    end

    def *(other)
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
      negative(self)
    end
  end
end
