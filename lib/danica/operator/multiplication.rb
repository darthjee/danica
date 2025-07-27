# frozen_string_literal: true

module Danica
  module Operator
    class Multiplication < Operator::Chained
      default_value :priority, 3

      private

      default_value :tex_symbol, '\cdot'
      default_value :gnu_symbol, :*

      def chain_operation(first, second)
        first * second
      end
    end
  end
end
