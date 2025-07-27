# frozen_string_literal: true

module Danica
  module Operator
    class Division < Operator
      variables :numerator, :denominator
      default_value :priority, 3
      default_value :is_grouped?, true

      def to_f
        numerator.to_f / denominator
      end

      def to_tex(**)
        "\\frac{#{numerator.to_tex(**)}}{#{denominator.to_tex(**)}}"
      end

      def to_gnu(**)
        "(#{numerator.to_gnu(**)})/(#{denominator.to_gnu(**)})"
      end
    end
  end
end
