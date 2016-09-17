require 'danica/function/chained'

module Danica
  class Function
    class Sum < Chained
      private

      def tex_symbol
        '+'
      end

      def gnu_symbol
        '+'
      end

      def chain_operation(a, b)
        a + b
      end
    end
  end
end

