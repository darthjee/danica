# frozen_string_literal: true

module Danica
  module Equation
    class Builder
      attr_reader :variables

      def initialize(*variables, &)
        @variables = variables
        instance_eval(&)
      end

      def build
        vars = variables
        l = left
        r = right

        Class.new(Equation) do
          variables(*vars)

          define_method :left, l
          define_method :right, r
        end
      end

      def left(&block)
        @left = block if block_given?
        @left
      end

      def right(&block)
        @right = block if block_given?
        @right
      end
    end
  end
end
