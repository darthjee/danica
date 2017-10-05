module Danica
  class Operator::SquaredRoot < Operator::Functional.build(operator: :sqrt, tex: '\sqrt{:value:}', gnu: 'sqrt(:value:)')
  end
end

