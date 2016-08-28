module Danica
  class Function
    class Division < Function
      attr_reader :numerator, :denominator

      def to_f
        numerator.to_f / denominator.to_f
      end

      def to_tex
        Number.new(to_f).to_tex
      rescue NotDefined
        "\\frac{#{numerator.to_tex}}{#{denominator.to_tex}}"
      end

      def numerator=(value)
        @numerator = wrap_value(value)
      end

      def denominator=(value)
        @denominator = wrap_value(value)
      end
    end
  end
end

