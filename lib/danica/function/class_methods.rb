class Danica::Function
  class << self
    def variables(*names)
      variable_names << names.map(&:to_sym)
      attr_accessor *names
    end

    private

    def variable_names
      @variable_names ||= []
    end
  end
end
