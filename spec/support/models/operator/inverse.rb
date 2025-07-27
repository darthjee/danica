# frozen_string_literal: true

module Danica
  module Operator
    class Inverse < Danica::Operator
      variables :value

      def to_f
        value.to_f**-1 # Do not worry with nil value as this has been implemented already raising Danica::Exception::NotDefined
      end

      def to_tex
        "(#{value.to_tex})^{-1}"
      end

      def to_gnu
        "(#{value.to_gnu}) ** -1"
      end
    end
  end
end
