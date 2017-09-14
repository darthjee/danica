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

      def to_tex
        variables.map(&:to_tex).join(" #{tex_symbol} ")
      end

      def to_gnu
        variables.map(&:to_gnu).join(" #{gnu_symbol} ")
      end

      private

      def repack(other)
        other_variables = other.is_a?(self.class) ? other.variables : [ other ]
        self.class.new(variables + other_variables)
      end

      def chain(numbers)
        numbers.inject do |a,b|
          chain_operation(a,b)
        end.to_f
      end
    end
  end
end

