module Danica
  class Operator
    class Chained < Operator

      def to_f
        chain(variables.map(&:to_f))
      end

      def include?(value)
        value = wrap_value(value)
        variables.include?(value)
      end

      private

      def tex_string
        (numeric_to_tex + non_numeric_variables.map(&:to_tex)).join(" #{tex_symbol} ")
      end

      def gnu_string
        (numeric_to_tex + non_numeric_variables.map(&:to_gnu)).join(" #{gnu_symbol} ")
      end

      def numeric_variables
        variables.select { |v| v.valued? }
      end

      def non_numeric_variables
        variables.reject { |v| v.valued? }
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

