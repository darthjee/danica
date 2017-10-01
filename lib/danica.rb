require 'active_model'

module Danica
  autoload :BaseOperations,   'danica/base_operations'
  autoload :VariablesHolder,  'danica/variables_holder'
  autoload :Common,           'danica/common'
  autoload :Number,           'danica/number'
  autoload :Negative,         'danica/negative'
  autoload :PositiveNegative, 'danica/positive_negative'
  autoload :Group,            'danica/group'
  autoload :Variable,         'danica/variable'
  autoload :Operator,         'danica/operator'
  autoload :Function,         'danica/function'
  autoload :Exception,        'danica/exception'
  autoload :Constant,         'danica/constant'

  autoload :Product,          'danica/product'
  autoload :Sum,              'danica/sum'
  autoload :Division,         'danica/division'
  autoload :Power,            'danica/power'
  autoload :SquaredRoot,      'danica/squared_root'
  autoload :Exponential,      'danica/exponential'
  autoload :Sin,              'danica/sin'
  autoload :Cos,              'danica/cos'

  E = Constant.new(Math::E, :e, 'exp(1)')
  PI =  Constant.new(Math::PI, '\pi', :pi)
end

