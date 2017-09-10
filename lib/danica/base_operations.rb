module Danica
  module BaseOperations
    def +(other)
      return Sum.new(self, other)
    end

    def *(other)
      return Product.new(self, other)
    end
  end
end
