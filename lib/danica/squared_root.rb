module Danica
  class SquaredRoot < Operator
    variables :variable

    priority 3

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

