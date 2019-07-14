# frozen_string_literal: true

module Danica
  class Operator::Division < Operator
    variables :numerator, :denominator
    default_value :priority, 3
    default_value :is_grouped?, true

    def to_f
      numerator.to_f / denominator.to_f
    end

    def to_tex(**options)
      "\\frac{#{numerator.to_tex(options)}}{#{denominator.to_tex(options)}}"
    end

    def to_gnu(**options)
      "(#{numerator.to_gnu(options)})/(#{denominator.to_gnu(options)})"
    end
  end
end
