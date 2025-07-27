# frozen_string_literal: true

module Danica
  module VariablesHolder
    class Store
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

      def extract_variables
        inner_containers_hash.merge(named_variables_hash)
      end

      private

      def named_variables_hash
        variable_variables.inject({}) do |hash, (key, container)|
          hash.merge((container.content.name || key).to_sym => container)
        end
      end

      def variable_variables
        containers_hash.select do |_, container|
          container.variable?
        end
      end

      def inner_containers_hash
        variable_holders.inject({}) do |hash, container|
          hash.merge!(container.content.extract_variables)
        end
      end

      def variable_holders
        variables.select(&:variable_holder?)
      end

      def default_containers_hash
        default_variables_hash.change_values do |value|
          Wrapper::Container.new(value)
        end
      end
    end
  end
end
