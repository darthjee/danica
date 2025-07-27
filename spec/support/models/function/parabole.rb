# frozen_string_literal: true

module Danica
  module Function
    class Parabole < Function.build(:x) { Danica::Parabole.new }
    end
  end
end

module Danica
  module Function
    class SaddleParabole < Function::Parabole
      variables :y

      def function_block
        super - power(y, 2)
      end
    end
  end
end
