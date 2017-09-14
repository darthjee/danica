class Danica::Common
  class << self
    def variables(*names)
      VariablesBuilder.new(names, self).build
    end

    def variables_names
      @variables_names ||= []
    end

    def priority(value)
      define_method :priority  { value }
    end
  end
end
