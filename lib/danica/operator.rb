module Danica
  class Operator
    include Common
    include VariablesHolder
    include BaseOperations
    include ActiveModel::Model

    default_value :priority, 3
    default_value :is_grouped?, false
  
    def initialize(*args)
      super( variables: args.flatten )
    end

    def ==(other)
      return false unless other.class == self.class
      variables == other.variables
    end

    autoload :Product,          'danica/operator/product'
    autoload :Addition,              'danica/operator/addition'
    autoload :Division,         'danica/operator/division'
    autoload :Power,            'danica/operator/power'
    autoload :Cos,              'danica/operator/cos'
    autoload :Sin,              'danica/operator/sin'
    autoload :SquaredRoot,      'danica/operator/squared_root'
    autoload :Exponential,      'danica/operator/exponential'
  end
end
