# frozen_string_literal: true

module Danica
  module Wrapper
    def wrap_value(value)
      Wrapper.wrap_value(value)
    end

    def self.wrap_value(value)
      case value
      when Formatted
        value.content
      when Numeric
        wrap_numeric(value)
      when Hash
        wrap_hash(value)
      when String, Symbol, NilClass
        Variable.new(name: value)
      else
        raise Exception::InvalidInput, value unless value.is_a?(Danica::Common)
        value
      end
    end

    def self.wrap_numeric(number)
      return Negative.new(Number.new(-number)) if number < 0
      Number.new(number)
    end

    def self.wrap_hash(hash)
      return Constant.new(hash) if hash.keys.map(&:to_sym).sort == %i[gnuplot latex value]
      Variable.new(hash)
    end

    autoload :Number,    'danica/wrapper/number'
    autoload :Group,     'danica/wrapper/group'
    autoload :Negative,  'danica/wrapper/negative'
    autoload :PlusMinus, 'danica/wrapper/plus_minus'
    autoload :Constant,  'danica/wrapper/constant'
    autoload :Variable,  'danica/wrapper/variable'
    autoload :Container, 'danica/wrapper/container'
  end
end
