module Danica
  class Function
    class Sum < Function
      def to_f
        sum(variables.map(&:to_f))
      end

      def to_tex
        (numeric_to_tex + non_numeric_variables.map(&:to_tex)).join('+')
      end

      private

      def numeric_variables
        variables.select { |v| v.value }
      end

      def non_numeric_variables
        variables.reject { |v| v.value }
      end

      def sum(numbers)
        numbers.inject(0) do |a,b|
          a + b
        end.to_f
      end

      def numeric_to_tex
        return [] if numeric_variables.empty?
        [ sum(numeric_variables.map(&:to_f)).to_i ]
      end
    end
  end
end

