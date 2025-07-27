# frozen_string_literal: true

module Danica
  module Function
    class MyFunction < Danica::Function
      variables :x, :y

      def function_block
        (x**2) + y
      end
    end
  end
end
