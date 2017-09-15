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
        to_string(:tex)
      end

      def to_gnu
        to_string(:gnu)
      end

      private

      def to_string(type)
        extractor = string_extractor("to_#{type}")
        symbol = { tex: tex_symbol, gnu: gnu_symbol }[type]
        variables.procedural_join(extractor, &join_proc(symbol))
      end

      def join_proc(symbol)
        proc { " #{symbol} " }
      end

      def string_extractor(method)
        proc do |parcel|
          parcel = Group.new(parcel) if parcel.priority < priority
          parcel.public_send(method)
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

