module Danica
  class VariablesHolder::Store
    attr_reader :default_variables_hash, :variables_names

    def initialize(default_variables_hash)
      @default_variables_hash = default_variables_hash
      @variables_names = default_variables_hash.keys
    end

    def containers_hash
      @containers_hash ||= {}.merge(default_containers_hash)
    end

    def containers
      containers_hash.values
    end

    def variables
      containers.map(&:content)
    end

    def variables_hash
      containers_hash.change_values(&:content)
    end

    def variables_value_hash
      variables.map do |var|
        var.try(:value)
      end.as_hash(variables_names)
    end

    private

    def default_containers_hash
      default_variables_hash.change_values do |value|
        Wrapper::Container.new(value)
      end
    end
  end
end

