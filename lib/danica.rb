require 'active_model'

module Danica
  autoload :Builder,          'danica/builder'
  autoload :BaseOperations,   'danica/base_operations'
  autoload :VariablesHolder,  'danica/variables_holder'
  autoload :Common,           'danica/common'
  autoload :PositiveNegative, 'danica/positive_negative'
  autoload :Variable,         'danica/variable'
  autoload :Function,         'danica/function'
  autoload :Exception,        'danica/exception'
  autoload :Constant,         'danica/constant'

  autoload :DSL,              'danica/dsl'
  autoload :Wrapper,          'danica/wrapper'
  autoload :Operator,         'danica/operator'

  class << self
    delegate :build, to: :builder

    def builder
      @builder ||= Builder.new
    end
  end

  E = Constant.new(Math::E, :e, 'exp(1)')
  PI =  Constant.new(Math::PI, '\pi', :pi)
end

