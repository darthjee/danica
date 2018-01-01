module Danica
  class Function::Hyperbole < Function.build(:x) { Danica::Hyperbole.new }
  end
end

module Danica
  class Function::SaddleHyperbole < Function::Hyperbole
    variables :y

    def function_block
      super - power(y, 2)
    end
  end
end

