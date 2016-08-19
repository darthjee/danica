module Danica
  class Function
    class Product < Function
      def to_f
        product(variables.map(&:to_f))
      end

      def to_tex
        (numeric_to_tex + non_numeric_variables.map(&:to_tex)).join('\cdot')
      end

      private

      def numeric_variables
        variables.select { |v| v.value }
      end

      def non_numeric_variables
        variables.reject { |v| v.value }
      end

      def product(numbers)
        numbers.inject(1) do |a,b|
          a * b
        end.to_f
      end

      def numeric_to_tex
        return [] if numeric_variables.empty?
        [ Number.new(product(numeric_variables.map(&:to_f))).to_tex ]
      end
    end
  end
end
