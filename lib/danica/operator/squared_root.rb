module Danica
  class Operator::SquaredRoot < Operator
    variables :variable
    default_value :is_grouped?, true

    def to_f
      Math.sqrt(variable.to_f)
    end

    def to_tex
      "\\sqrt{#{variable.to_tex}}"
    end

    def to_gnu
      "sqrt(#{variable.to_gnu})"
    end
  end
end

