module Danica
  module Wrapper
    def wrap_value(value)
      case value
      when Numeric
        return negative(number(-value)) if value < 0
        number(value)
      when Hash
        return constant(value) if value.keys.map(&:to_sym).sort == %i(gnu latex value)
        variable(value)
      when String, Symbol
        variable(name: value)
      when NilClass
        variable
      else
        value
      end
    end

    autoload :Number,    'danica/wrapper/number'
    autoload :Group,     'danica/wrapper/group'
    autoload :Negative,  'danica/wrapper/negative'
    autoload :PlusMinus, 'danica/wrapper/plus_minus'
    autoload :Constant,  'danica/wrapper/constant'
    autoload :Variable,  'danica/wrapper/variable'
  end
end
