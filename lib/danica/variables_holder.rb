module Danica
  module VariablesHolder extend ::ActiveSupport::Concern
    require 'danica/variables_holder/variables_builder'

    included do
      class << self
        def variables(*names)
          VariablesBuilder.new(names, self).build
        end

        def variables_names
          @variables_names ||= []
        end
      end
    end

    attr_accessor :variables
 
    def variables=(variables)
      @variables = variables.map { |v| wrap_value(v) }
    end

    def variables
      @variables ||= variables_hash.values
    end
  
    def variables_hash
      @variabels_map ||= (@variables || []).as_hash(self.class.variables_names)
    end

    def variables_value_hash
      variables.map(&:value).as_hash(self.class.variables_names)
    end

    private

    def non_valued_variables
      variables.reject(&:valued?)
    end
  end
end
