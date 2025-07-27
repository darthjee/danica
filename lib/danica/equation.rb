# frozen_string_literal: true

module Danica
  class Equation
    include VariablesHolder

    autoload :Builder, 'danica/equation/builder'

    class << self
      def build(*variables, &block)
        Builder.new(*variables, &block).build
      end

      def create(*variables, &block)
        build(*variables, &block).new
      end
    end

    def to(format, **options)
      "#{left.to(format, **options)} = #{right.to(format, **options)}"
    end
  end
end
