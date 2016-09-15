module Danica
  class Function
    class SquareRoot < Function
      variables :variable

      def to_f
        Math.sqrt(variable.to_f)
      end

      private

      def tex_string
        "\\sqrt{#{variable.to_tex}}"
      end

      def gnu_string
        "sqrt(#{variable.to_gnu})"
      end
    end
  end
end

