module Danica
  class Function
    class Division < Function
      attr_reader :numerator, :denominator

      def to_f
        numerator.to_f / denominator.to_f
      end

      def numerator=(value)
        @numerator = wrap_value(value)
      end

      def denominator=(value)
        @denominator = wrap_value(value)
      end

      private

      def tex_string
        "\\frac{#{numerator.to_tex}}{#{denominator.to_tex}}"
      end

      def gnu_string
        "#{numerator.to_gnu}/#{denominator.to_gnu}"
      end
    end
  end
end

