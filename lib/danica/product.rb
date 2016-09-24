require 'danica/operator/chained'

module Danica
  class Product < Operator::Chained
    private

    def tex_symbol
    '\cdot'
    end

    def gnu_symbol
    '*'
    end

    def chain_operation(a, b)
    a * b
    end
  end
end
