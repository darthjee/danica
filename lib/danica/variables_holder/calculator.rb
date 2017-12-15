module Danica
  module VariablesHolder
    class Calculator
      attr_accessor :object, :args

      delegate :variables_value_hash, to: :object

      def initialize(object, *args)
        @object = object
        @args = args
      end

      def calculate
        raise Exception::NotDefined unless all_valued?

        clazz.new(vars_map).to_f
      end

      private

      def all_valued?
        vars_map.values.all? { |v| valued?(v) }
      end

      def vars_map
        @vars_map ||= variables_value_hash.dup.tap do |map|
          vars = args.dup
          map.merge! vars.extract_options!
          map.each do |name, value|
            unless valued?(value)
              map[name] = vars.shift
            end
          end
        end
      end

      def valued?(value)
        value.is_a?(Integer) || value.try(:valued?)
      end

      def clazz
        @clazz ||= object.class
      end
    end
  end
end
