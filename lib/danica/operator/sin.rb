module Danica
  class Operator::Sin < Operator::Functional.build(operator: :sin, tex: 'sin(:value:)', gnu: 'sin(:value:)')
  end
end

