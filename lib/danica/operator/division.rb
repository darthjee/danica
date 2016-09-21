module Danica
  class Operator
    class Division < Operator
      variables :numerator, :denominator

      def to_f
        numerator.to_f / denominator.to_f
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

