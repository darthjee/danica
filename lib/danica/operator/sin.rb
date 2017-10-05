module Danica
  class Operator::Sin < Operator
    variables :value

    def to_f
      Math.sin(value.to_f)
    end

    def to_tex
      "sin(#{value.to_tex})"
    end

    def to_gnu
      "sin(#{value.to_gnu})"
    end
  end
end


