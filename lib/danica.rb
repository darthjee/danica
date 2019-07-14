# frozen_string_literal: true

require 'darthjee/core_ext'

module Danica
  autoload :Builder,          'danica/builder'
  autoload :BaseOperations,   'danica/base_operations'
  autoload :VariablesHolder,  'danica/variables_holder'
  autoload :Common,           'danica/common'
  autoload :Expression,       'danica/expression'
  autoload :Equation,         'danica/equation'
  autoload :Function,         'danica/function'
  autoload :Exception,        'danica/exception'
  autoload :Expressable,      'danica/expressable'
  autoload :Formatted,        'danica/formatted'

  autoload :DSL,              'danica/dsl'
  autoload :Wrapper,          'danica/wrapper'
  autoload :Operator,         'danica/operator'

  autoload :PI,               'danica/wrapper/constant'

  class << self
    delegate :build, to: :builder
    attr_accessor :debug

    def builder
      @builder ||= Builder.new
    end
  end
end
