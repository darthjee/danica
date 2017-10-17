module Danica
  class Function::Name
    include Common
    attr_reader :name, :variables

    def initialize(name:, variables:)
      @name = name
      @variables = variables
    end

    def to(format)
      "#{name}(#{description_variables(format)})"
    end

    private

    def description_variables(format)
      non_constant_variables.map { |v| v.to(format) }.join(', ')
    end

    def non_constant_variables
      variables.reject(&:constant?)
    end
  end
end
