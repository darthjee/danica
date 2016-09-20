class Danica::Operator
  class << self
    def variables(*names)
      VariablesBuilder.new(names, self).build
    end

    def variables_names
      @variables_names ||= []
    end
  end
end
