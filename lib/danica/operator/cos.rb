module Danica
  class Operator::Cos < Operator::Functional.build(operator: :cos, tex: 'cos(:value:)', gnu: 'cos(:value:)')
  end
end

