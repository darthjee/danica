# frozen_string_literal: true

module Danica
  class Operator::Power < Operator
    variables :base, :exponent
    default_value :is_grouped?, false

    def to_f
      base.to_f**exponent.to_f
    end

    def to_tex(**)
      "#{wrap_as_group(base).to_tex(**)}^{#{exponent.to_tex(**)}}"
    end

    def to_gnu(**)
      "#{wrap_as_group(base).to_gnu(**)}**(#{exponent.to_gnu(**)})"
    end
  end
end
