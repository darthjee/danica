require 'active_model'

module Danica
  autoload :Common,      'danica/common'
  autoload :Number,      'danica/number'
  autoload :Variable,    'danica/variable'
  autoload :Operator,    'danica/operator'
  autoload :Function,    'danica/function'
  autoload :Exception,   'danica/exception'
  autoload :Constant,    'danica/constant'

  autoload :Product,     'danica/product'
  autoload :Sum,         'danica/sum'
  autoload :Division,    'danica/division'
  autoload :Power,       'danica/power'
  autoload :SquareRoot,  'danica/square_root'
  autoload :Exponential, 'danica/exponential'
  autoload :Sin,         'danica/sin'
  autoload :Cos,         'danica/cos'
end

