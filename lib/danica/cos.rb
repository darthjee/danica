module Danica
  class Cos < Operator
    variables :variable

    def to_f
      Math.cos(variable.to_f)
    end

    private

    def tex_string
      "cos(#{variable.to_tex})"
    end

    def gnu_string
      "cos(#{variable.to_gnu})"
    end
  end
end



