module Danica
  class Builder
    include DSL

    def build(*vars, &block)
      Expression.create(*vars, &block).tap do |expression|
        return expression.expression_block if expression.expression_block.is_a? Expressable
      end
    end
  end
end
