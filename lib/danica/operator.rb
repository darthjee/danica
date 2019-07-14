# frozen_string_literal: true

module Danica
  class Operator
    include VariablesHolder
    include BaseOperations

    default_value :priority, 4
    default_value :is_grouped?, false

    def ==(other)
      return false unless other.class == self.class
      variables == other.variables
    end

    autoload :Functional,     'danica/operator/functional'
    autoload :Chained,        'danica/operator/chained'
    autoload :Multiplication, 'danica/operator/multiplication'
    autoload :Addition,       'danica/operator/addition'
    autoload :Division,       'danica/operator/division'
    autoload :Power,          'danica/operator/power'
    autoload :Cos,            'danica/operator/cos'
    autoload :Sin,            'danica/operator/sin'
    autoload :SquaredRoot,    'danica/operator/squared_root'
    autoload :Exponential,    'danica/operator/exponential'
  end
end
