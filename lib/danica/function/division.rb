module Danica
  class Function
    class Division < Function
      attr_accessor :numerator, :denominator

      def to_f
        numerator.to_f / denominator.to_f
      end

      def to_tex
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

