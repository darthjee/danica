# frozen_string_literal: true

module Danica
  class Operator
    class Chained < Operator
      def variables=(vars)
        @variables = vars.map { |v| wrap_value(v) }
      end

      def to_f
        chain(variables.map(&:to_f))
      end

      def include?(value)
        value = wrap_value(value)
        variables.include?(value.content)
      end

      def to(format, **options)
        extractor = string_extractor(format, **options)
        variables.procedural_join(extractor, &join_proc(symbol(format)))
      end

      def variables
        @variables.map(&:content)
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

      def string_extractor(format, **options)
        proc do |parcel|
          parcel = wrap_as_group(parcel)
          parcel.to(format, **options)
        end
      end

      def chain(numbers)
        numbers.inject do |a, b|
          chain_operation(a, b)
        end.to_f
      end
    end
  end
end
