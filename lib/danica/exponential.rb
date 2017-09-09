module Danica
  class Exponential < Operator
    variables :exponent

    def to_f
      Math.exp(exponent.to_f)
    end

    private

    def tex_string
      "e^{#{exponent.to_tex}}"
    end

    def gnu_string
      "exp(#{exponent.to_gnu})"
    end
  end
end


