module Danica
  class Operator::Exponential < Operator::Functional.build(operator: :exp, tex: 'e^{:value:}')
  end
end

