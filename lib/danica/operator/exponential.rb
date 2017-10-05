module Danica
  class Operator::Exponential < Operator::Functional.build(operator: :exp, tex: 'e^{:value:}', gnu: 'exp(:value:)')
  end
end

