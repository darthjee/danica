module Danica
  class Sin < Operator
    variables :variable

    priority 3

    def to_f
      Math.sin(variable.to_f)
    end

    def to_tex
      "sin(#{variable.to_tex})"
    end

    def to_gnu
      "sin(#{variable.to_gnu})"
    end
  end
end


