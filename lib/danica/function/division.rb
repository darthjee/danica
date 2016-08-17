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
    end
  end
end

