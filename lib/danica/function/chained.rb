module Danica
  class Function
    class Chained < Function
      def to_f
        chain(variables.map(&:to_f))
      end

      private

      def numeric_variables
        variables.select { |v| v.value }
      end

      def non_numeric_variables
        variables.reject { |v| v.value }
      end

      def chain(numbers)
        numbers.inject do |a,b|
          chain_operation(a,b)
        end.to_f
      end
    end
  end
end

