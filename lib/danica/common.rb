module Danica
  class Common
    include BaseOperations
    require 'danica/common/class_methods'
    require 'danica/common/variables_builder'

    attr_accessor :variables
 
    def to_f
      raise 'Not IMplemented yet'
    end
  
    def to_tex
      tex_string
    end

    def to_gnu
      gnu_string
    end
  
    def variables=(variables)
      @variables = variables.map { |v| wrap_value(v) }
    end
  
    def valued?
      to_f.present?
    rescue Exception::NotDefined
      false
    end

    def variables
      @variables ||= variables_hash.values
    end
  
    def variables_hash
      @variabels_map ||= (@variables || []).as_hash(self.class.variables_names)
    end

    def variables_value_hash
      variables.map(&:value).as_hash(self.class.variables_names)
    end

    private

    def non_valued_variables
      variables.reject(&:valued?)
    end

    def tex_string
      raise 'Not IMplemented yet'
    end

    def gnu_string
      raise 'Not IMplemented yet'
    end
  
    def wrap_value(value)
      return Number.new(value) if value.is_a?(Numeric)
      return Variable.new(value) if value.is_a?(Hash)
      return Variable.new(name: value) if [ String, Symbol ].any? { |c| value.is_a?(c) }
      return Variable.new if value.nil?
      value
    end
  end
end
