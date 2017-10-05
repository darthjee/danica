module Danica
  class Operator::SquaredRoot < Operator::Functional.build(operator: :sqrt, tex: '\sqrt{:value:}')
  end
end

