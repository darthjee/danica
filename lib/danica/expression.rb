module Danica
  class Expression
    include Common
    include DSL
    include BaseOperations
    include VariablesHolder

    autoload :Gauss,    'danica/expression/gauss'

    delegate :to_f, :to, :is_grouped?, :priority, to: :expression_block

    def self.build(*vars, &block)
      Class.new(self) do
        variables(*vars)

        private

        define_method :expression_block do
          @function_block ||= instance_eval(&block) if block
        end
      end
    end

    def self.create(*vars, &block)
      build(*vars, &block).new
    end

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end
  end
end
