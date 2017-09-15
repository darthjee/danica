require 'danica/operator/chained'

module Danica
  class Product < Operator::Chained
    default_value :priority, 2

    def *(other)
      repack(other)
    end

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
