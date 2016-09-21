module Danica
  class Common
    require 'danica/common/class_methods'
    require 'danica/common/variables_builder'

    attr_accessor :variables
  
    def to_f
      raise 'Not IMplemented yet'
    end

    def calculate(*args)
      vars_map = args.extract_options!
      vars_map = variables_value_hash.merge(vars_map)
      vars_map.each do |k, v|
        unless v && (v.is_a?(Fixnum) || v.valued?)
          vars_map[k] = args.shift
        end
      end

      self.class.new(vars_map).to_f
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
      return Variable.new if value == nil
      value
    end
  end
end
