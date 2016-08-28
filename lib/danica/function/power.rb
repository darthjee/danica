module Danica
  class Function
    class Power < Function
      attr_reader :base, :exponent

      def to_f
        base.to_f ** exponent.to_f
      end

      def to_tex
        [ base, exponent ].map(&:to_tex).join('^')
      end

      def base=(value)
        @base = wrap_value(value)
      end

      def exponent=(value)
        @exponent = wrap_value(value)
      end
    end
  end
end

