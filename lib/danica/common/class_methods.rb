class Danica::Common
  class << self
    def variables(*names)
      VariablesBuilder.new(names, self).build
    end

    def variables_names
      @variables_names ||= []
    end

    def default_value(name, value)
      define_method(name) { value }
    end
  end
end
