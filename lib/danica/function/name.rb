# frozen_string_literal: true

module Danica
  module Function
    class Name
      include Common
      attr_reader :name, :containers

      def initialize(name:, variables:)
        @name = name || :f
        @containers = variables.map { |v| wrap_value(v) }
      end

      def to(format, **)
        "#{name}(#{description_variables(format, **)})"
      end

      def variables
        containers.map(&:content)
      end

      private

      def description_variables(format, **options)
        variables_for(format).map do |value|
          value.to(format, **options)
        end.join(', ')
      end

      def variables_for(format)
        case format.to_sym
        when :tex
          non_constant_variables
        when :gnu
          non_valued_variables
        end
      end

      def non_valued_variables
        variables.reject(&:valued?)
      end

      def non_constant_variables
        variables.reject(&:constant?)
      end
    end
  end
end
