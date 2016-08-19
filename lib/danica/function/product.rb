module Danica
  class Function
    class Product < Chained
      def to_tex
        (numeric_to_tex + non_numeric_variables.map(&:to_tex)).join('\cdot')
      end

      private

      def chain_operation(a, b)
        a * b
      end

      def numeric_to_tex
        return [] if numeric_variables.empty?
        [ Number.new(chain(numeric_variables.map(&:to_f))).to_tex ]
      end
    end
  end
end
