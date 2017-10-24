module Danica
  class Hyperbole < Expression.build(:x) { power(x, 2) }
  end
end

module Danica
  class SaddleHyperbole < Hyperbole
    variables :y

    def expression_block
      super - power(y, 2)
    end
  end
end
