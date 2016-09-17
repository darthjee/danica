require 'danica/function/chained'

module Danica
  class Function
    class Product < Chained
      private

      def tex_symbol
        '\cdot'
      end

      def gnu_symbol
        '*'
      end

      def chain_operation(a, b)
        a * b
      end
    end
  end
end
