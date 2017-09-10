require 'danica/operator/chained'

module Danica
  class Sum < Operator::Chained
    def +(other)
      other_variables = other.is_a?(self.class) ? other.variables : [ other ]
      Sum.new(variables + other_variables)
    end

    private

    def tex_symbol
      '+'
    end

    def gnu_symbol
      '+'
    end

    def chain_operation(a, b)
      a + b
    end
  end
end

