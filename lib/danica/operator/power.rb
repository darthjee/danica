module Danica
  class Operator
    class Power < Operator
      variables :base, :exponent

      def to_f
        base.to_f ** exponent.to_f
      end

      private

      def tex_string
        "#{base.to_tex}^{#{exponent.to_tex}}"
      end

      def gnu_string
        "#{base.to_gnu}**#{exponent.to_gnu}"
      end
    end
  end
end

