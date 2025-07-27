# frozen_string_literal: true

module Danica
  module Operator
    class SquaredRoot < Operator::Functional.build(operator: :sqrt, tex: '\sqrt{:value:}')
    end
  end
end
