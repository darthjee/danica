module Danica
  class Parabole < Expression.build(:x) { power(x, 2) }
  end
end

module Danica
  class SaddleParabole < Parabole
    variables :y

    def expression_block
      super - power(y, 2)
    end
  end
end
