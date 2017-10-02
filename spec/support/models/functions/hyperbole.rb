module Danica
  class Hyperbole < Function.build(:x)
  end
end

module Danica
  class SaddleHyperbole < Hyperbole
    variables :y
  end
end
