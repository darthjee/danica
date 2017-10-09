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
      vars = vars.as_hash(self.class.variables_names) unless vars.is_a? Hash
      vars = vars.change_values { |v| wrap_value(v) }
      @variables_hash = self.class.variables_hash.merge(vars)
    end

    def variables
      variables_hash.values
    end
  
    def variables_hash
      @variables_hash ||= {}.merge(self.class.variables_hash)
    end

    def variables_value_hash
      variables.map do |var|
        var.try(:value)
      end.as_hash(self.class.variables_names)
    end

    private

    def non_valued_variables
      variables.reject(&:valued?)
    end
  end
end
