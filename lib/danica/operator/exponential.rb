# frozen_string_literal: true

module Danica
  module Operator
    class Exponential < Operator::Functional.build(operator: :exp, tex: 'e^{:value:}')
    end
  end
end
