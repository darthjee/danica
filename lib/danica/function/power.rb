module Danica
  class Function
    class Power < Function
      attr_reader :base, :exponent

      def to_f
        base.to_f ** exponent.to_f
      end

      def base=(value)
        @base = wrap_value(value)
      end

      def exponent=(value)
        @exponent = wrap_value(value)
      end

      private

      def tex_string
        "#{base.to_tex}^{#{exponent.to_tex}}"
      end

      def gnu_string
        "#{base.to_tex}**#{exponent.to_tex}"
      end
    end
  end
end

