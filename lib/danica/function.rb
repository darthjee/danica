module Danica
  class Function
    include ActiveModel::Model
  
    require 'danica/function/chained'
    require 'danica/function/product'
    require 'danica/function/sum'
    require 'danica/function/division'
    require 'danica/function/power'
    require 'danica/function/square_root'
  
    attr_accessor :name, :variables
  
    def to_f
      raise 'Not IMplemented yet'
    end
  
    def to_tex
      Number.new(to_f).to_tex
    rescue Exception::NotDefined
      tex_string
    end
  
    def variables=(variables)
      @variables = variables.map { |v| wrap_value(v) }
    end
  
    def valued?
      to_f.presend?
    rescue Exception::NotDefined
      false
    end
  
    private
  
    def tex_string
      raise 'Not IMplemented yet'
    end
  
    def wrap_value(value)
      return Number.new(value) if value.is_a?(Numeric)
      return Variable.new(value) if value.is_a?(Hash)
      return Variable.new(name: value) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      value
    end
  end
end
