module Danica
  class Operator::Exponential < Operator
    variables :exponent
    default_value :is_grouped?, true

    def to_f
      Math.exp(exponent.to_f)
    end

    def to_tex
      "e^{#{exponent.to_tex}}"
    end

    def to_gnu
      "exp(#{exponent.to_gnu})"
    end
  end
end


