module Danica
  class Expression
    class QuadraticSum < build(:x, :y) { (x + y) ** 2 }
    end
  end
end
