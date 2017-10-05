module Danica
  class Operator::Cos < Operator
    variables :value

    def to_f
      Math.cos(value.to_f)
    end

    def to_tex
      "cos(#{value.to_tex})"
    end

    def to_gnu
      "cos(#{value.to_gnu})"
    end
  end
end



