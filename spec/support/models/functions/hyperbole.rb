module Danica
  class Hyperbole < Function.build(:x) { power(x, 2) }
  end
end

module Danica
  class SaddleHyperbole < Hyperbole
    variables :y

    def function_block
      super - power(y, 2)
    end
  end
end
