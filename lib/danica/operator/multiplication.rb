module Danica
  class Operator::Multiplication < Operator::Chained
    default_value :priority, 2

    private

    default_value :tex_symbol, '\cdot'
    default_value :gnu_symbol, :*

    def chain_operation(a, b)
      a * b
    end
  end
end
