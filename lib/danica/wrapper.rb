module Danica
  module Wrapper
    def wrap_value(value)
      return wrap_value(number(value)) if value.is_a?(Numeric)
      return wrap_value(Constant.new(value)) if value.is_a?(Hash) && value[:value]
      return wrap_value(variable(value)) if value.is_a?(Hash)
      return wrap_value(variable(name: value)) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return wrap_value(variable) if value.nil?
      value
    end

    autoload :Number,    'danica/wrapper/number'
    autoload :Group,     'danica/wrapper/group'
    autoload :Negative,  'danica/wrapper/negative'
    autoload :PlusMinus, 'danica/wrapper/plus_minus'
    autoload :Constant,  'danica/wrapper/constant'
    autoload :Variable,  'danica/wrapper/variable'
  end
end
