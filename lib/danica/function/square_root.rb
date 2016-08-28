module Danica
  class Function
    class SquareRoot < Function
      attr_reader :variable

      def to_f
        Math.sqrt(variable.to_f)
      end

      def variable=(value)
        @variable = wrap_value(value)
      end

      private

      def tex_string
        "\\sqrt{#{variable.to_tex}}"
      end
    end
  end
end

