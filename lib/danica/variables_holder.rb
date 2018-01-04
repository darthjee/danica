module Danica
  module VariablesHolder extend ::ActiveSupport::Concern
    include Common

    autoload :VariablesBuilder, 'danica/variables_holder/variables_builder'
    autoload :AliasBuilder,     'danica/variables_holder/alias_builder'
    autoload :Calculator,       'danica/variables_holder/calculator'
    autoload :Store,            'danica/variables_holder/store'

    delegate :containers_hash, :containers, :variables,
             :variables_hash, :variables_value_hash,
             :extract_variables, to: :store

    included do
      default_value :variable_holder?,  true

      class << self
        def variables(*names)
          VariablesBuilder.new(names, self).build
        end

        def variable_alias(origin, destiny)
          AliasBuilder.new(origin, destiny, self).build
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

    def initialize(*args)
      args = args.flatten
      args = args.first if (args.length == 1) && args.first.is_a?(Hash) && args.first.keys.all? { |k| self.class.variables_names.include?(k) }
      self.variables = args
    end

    def variables=(vars)
      vars = vars.as_hash(self.class.variables_names).compact unless vars.is_a? Hash
      vars = vars.dup.change_values!(skip_inner: false) { |v| wrap_value(v) }
      vars.each do |k, v|
        public_send("#{k}=", v)
      end
    end

    def calculate(*args)
      Calculator.new(self, *args).calculate
    end

    private

    def store
      @store ||= Store.new(self.class.variables_hash)
    end
  end
end
