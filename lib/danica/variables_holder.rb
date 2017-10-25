module Danica
  module VariablesHolder extend ::ActiveSupport::Concern
    require 'danica/variables_holder/variables_builder'

    included do
      class << self
        def variables(*names)
          VariablesBuilder.new(names, self).build
        end

        def variables_names
          variables_hash.keys
        end

        def variables_hash
          @variables_hash ||= superclass_variables_hash.dup
        end

        def reset_variables
          @superclass_variables_hash = {}
          @variables_hash = nil
        end

        def superclass_variables_hash
          @superclass_variables_hash ||= (superclass.try(:variables_hash) || {})
        end
      end
    end

    def variables=(vars)
      vars = vars.as_hash(self.class.variables_names).compact unless vars.is_a? Hash
      vars = vars.dup.change_values!(skip_inner: false) { |v| wrap_value(v) }
      vars.each do |k, v|
        public_send("#{k}=", v)
      end
    end

    def variables
      containers.map(&:content)
    end

    def containers
      containers_hash.values
    end

    def containers_hash
      @containers_hash ||= {}.merge(self.class.variables_hash.change_values do |value|
        Wrapper::Container.new(value)
      end)
    end

    def variables_hash
      containers_hash.change_values(&:content)
    end

    def variables_value_hash
      variables.map do |var|
        var.try(:value)
      end.as_hash(self.class.variables_names)
    end
  end
end
