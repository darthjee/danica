# frozen_string_literal: true

module Danica
  class Equation
    include VariablesHolder

    autoload :Builder, 'danica/equation/builder'

    class << self
      def build(*variables, &)
        Builder.new(*variables, &).build
      end

      def create(*variables, &)
        build(*variables, &).new
      end
    end

    def to(format, **options)
      "#{left.to(format, **options)} = #{right.to(format, **options)}"
    end
  end
end
