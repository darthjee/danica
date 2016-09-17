module Danica
  class Function
    include ActiveModel::Model
  
    require 'danica/function/variables_builder'
    require 'danica/function/class_methods'
    require 'danica/function/chained'
    require 'danica/function/product'
    require 'danica/function/sum'
    require 'danica/function/division'
    require 'danica/function/power'
    require 'danica/function/square_root'
  
    attr_accessor :name, :variables

    def initialize(*args)
      options = args.extract_options!

      super({ variables: args.flatten }.merge(options))
    end
  
    def to_f
      raise 'Not IMplemented yet'
    end

    def calculate(*args)
      vars = non_valued_variables

      vars.each.with_index do |v, i|
        v.value = args[i]
      end

      to_f.tap do
        vars.each { |v| v.value = nil }
      end
    end
  
    def to_tex
      Number.new(to_f).to_tex
    rescue Exception::NotDefined
      tex_string
    end

    def to_gnu
      Number.new(to_f).to_gnu
    rescue Exception::NotDefined
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
      value
    end
  end
end
