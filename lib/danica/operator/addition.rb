# frozen_string_literal: true

module Danica
  module Operator
    class Addition < Operator::Chained
      default_value :priority, 1

      private

      default_value :symbol, :+

      def chain_operation(first, second)
        first + second
      end

      def join_proc(symbol)
        proc do |_, value|
          value.signaled? ? ' ' : " #{symbol} "
        end
      end
    end
  end
end
