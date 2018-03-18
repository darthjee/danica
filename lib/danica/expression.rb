module Danica
  class Expression
    include Common
    include DSL
    include BaseOperations
    include Expressable

    autoload :Gauss,    'danica/expression/gauss'

    delegate :is_grouped?, :priority, to: :expression_block

    built_with(:expression_block)
  end
end
