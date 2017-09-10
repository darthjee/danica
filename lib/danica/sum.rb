require 'danica/operator/chained'

module Danica
  class Sum < Operator::Chained
    def +(other)
      Sum.new(variables + [ other ])
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

