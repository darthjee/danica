module Danica
  module Wrapper
    def wrap_value(value)
      return number(value) if value.is_a?(Numeric)
      return constant(value) if value.is_a?(Hash) && value.keys.map(&:to_sym) == %i(value latex gnu)
      return variable(value) if value.is_a?(Hash)
      return variable(name: value) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return variable if value.nil?
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
