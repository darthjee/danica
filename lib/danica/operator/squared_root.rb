module Danica
  class Operator::SquaredRoot < Operator
    variables :value
    default_value :is_grouped?, true

    def to_f
      Math.sqrt(value.to_f)
    end

    def to_tex
      "\\sqrt{#{value.to_tex}}"
    end

    def to_gnu
      "sqrt(#{value.to_gnu})"
    end
  end
end

