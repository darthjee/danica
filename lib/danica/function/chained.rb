module Danica
  class Function
    class Chained < Function
      def to_f
        chain(variables.map(&:to_f))
      end

      def to_tex
        (numeric_to_tex + non_numeric_variables.map(&:to_tex)).join(tex_symbol)
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

      def numeric_to_tex
        return [] if numeric_variables.empty?
        [ Number.new(chain(numeric_variables.map(&:to_f))).to_tex ]
      end
    end
  end
end

