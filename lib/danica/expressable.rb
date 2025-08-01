# frozen_string_literal: true

module Danica
  module Expressable
    extend ::ActiveSupport::Concern
    include VariablesHolder

    class_methods do
      def built_with(block_name)
        delegate :to, :to_f, to: block_name

        define_singleton_method(:build) do |*vars, &block|
          Class.new(self) do
            variables(*vars)

            private

            module_eval do
              define_method block_name do
                instance_variable_get("@#{block_name}") ||
                  (block && instance_variable_set("@#{block_name}", instance_eval(&block)))
              end
            end
          end
        end

        define_singleton_method(:create) do |*vars, &block|
          build(*vars, &block).new
        end
      end
    end

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end
  end
end
