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
          @variables_hash ||= (superclass.try(:variables_hash) || {}).dup
        end
      end
    end

    def variables=(vars)
      vars = vars.as_hash(self.class.variables_names).compact unless vars.is_a? Hash
      vars = vars.change_values(skip_inner: false) { |v| wrap_value(v) }
      vars.each do |k, v|
        public_send("#{k}=", v)
      end
    end

    def variables
      variables_hash.values
    end

    def variables_hash
      @variables_hash ||= {}.merge(self.class.variables_hash.dup.change_values!(&:dup))
    end

    def variables_value_hash
      variables.map do |var|
        var.try(:value)
      end.as_hash(self.class.variables_names)
    end
  end
end
