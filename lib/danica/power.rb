module Danica
  class Power < Operator
    variables :base, :exponent

    priority 3

    def to_f
      base.to_f ** exponent.to_f
    end

    def to_tex
      "#{base.to_tex}^{#{exponent.to_tex}}"
    end

    def to_gnu
      "#{base.to_gnu}**#{exponent.to_gnu}"
    end
  end
end

