module Danica
  class Function
    class SquareRoot < Function
      attr_reader :variable

      def to_f
        Math.sqrt(variable.to_f)
      end

      def to_tex
        Number.new(to_f).to_tex
      rescue NotDefined
        "\\sqrt{#{variable.to_tex}}"
      end

      def variable=(value)
        @variable = wrap_value(value)
      end

    end
  end
end

