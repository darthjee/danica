module Danica
  class Cos < Operator
    variables :variable

    def to_f
      Math.cos(variable.to_f)
    end

    def to_tex
      "cos(#{variable.to_tex})"
    end

    def to_gnu
      "cos(#{variable.to_gnu})"
    end
  end
end



