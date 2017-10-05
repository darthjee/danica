require 'active_model'
require 'darthjee/core_ext'

module Danica
  autoload :Builder,          'danica/builder'
  autoload :BaseOperations,   'danica/base_operations'
  autoload :VariablesHolder,  'danica/variables_holder'
  autoload :Common,           'danica/common'
  autoload :Function,         'danica/function'
  autoload :Exception,        'danica/exception'

  autoload :DSL,              'danica/dsl'
  autoload :Wrapper,          'danica/wrapper'
  autoload :Operator,         'danica/operator'

  class << self
    delegate :build, to: :builder

    def builder
      @builder ||= Builder.new
    end
  end

  E = Wrapper::Constant.new(Math::E, :e, 'exp(1)')
  PI =  Wrapper::Constant.new(Math::PI, '\pi', :pi)
end

