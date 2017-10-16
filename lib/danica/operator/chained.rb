module Danica
  class Operator
    class Chained < Operator
      attr_reader :variables

      def variables=(vars)
        @variables = vars.map { |v| wrap_value(v) }
      end

      def to_f
        chain(variables.map(&:to_f))
      end

      def include?(value)
        value = wrap_value(value)
        variables.include?(value)
      end

      def to(format)
        extractor = string_extractor(format)
        variables.procedural_join(extractor, &join_proc(symbol(format)))
      end

      private

      def symbol(format)
        case format.to_sym
        when :tex
          tex_symbol
        when :gnu
          gnu_symbol
        end
      end

      def join_proc(symbol)
        proc { " #{symbol} " }
      end

      def string_extractor(method)
        proc do |parcel|
          parcel = wrap_as_group(parcel)
          parcel.to(method)
        end
      end

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

