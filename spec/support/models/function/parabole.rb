# frozen_string_literal: true

module Danica
  class Function::Parabole < Function.build(:x) { Danica::Parabole.new }
  end
end

module Danica
  class Function::SaddleParabole < Function::Parabole
    variables :y

    def function_block
      super - power(y, 2)
    end
  end
end
