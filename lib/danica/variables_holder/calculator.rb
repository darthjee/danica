module Danica
  module VariablesHolder
    class Calculator
      attr_accessor :object, :args

      def initialize(object, *args)
        @object = object
        @args = args
      end

      def calculate
        raise Exception::NotDefined unless all_valued?

        clazz.new(vars_map).to_f
      end

      private

      def vars_map
        @vars_map ||= variables_value_hash.tap do |map|
          vars = args.dup
          map.merge! vars.extract_options!
          non_valued_keys =  map.select { |_, value| !valued?(value) }.keys
          map.merge! vars.as_hash(non_valued_keys)
        end
      end

      def all_valued?
        vars_map.values.all? { |v| valued?(v) }
      end

      def valued?(value)
        value.is_a?(Integer) || value.try(:valued?)
      end

      def variables_value_hash
        @variables_value_hash ||= object.variables_value_hash.dup
      end

      def clazz
        @clazz ||= object.class
      end
    end
  end
end
