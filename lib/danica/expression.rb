# frozen_string_literal: true

module Danica
  class Expression
    autoload :Gauss, 'danica/expression/gauss'

    include Common
    include DSL
    include BaseOperations
    include Expressable

    delegate :is_grouped?, :priority, to: :expression_block

    built_with(:expression_block)
  end
end
