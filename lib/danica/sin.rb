module Danica
  class Sin < Operator
    variables :variable

    def to_f
      Math.sin(variable.to_f)
    end

    private

    def tex_string
      "sin(#{variable.to_tex})"
    end

    def gnu_string
      "sin(#{variable.to_gnu})"
    end
  end
end


