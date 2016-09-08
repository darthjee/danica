class Danica::Function
  class << self
    def variables(*names)
      VariablesBuilder.new(names, self).build
    end

    private

    def variable_names
      @variable_names ||= []
    end
  end
end
