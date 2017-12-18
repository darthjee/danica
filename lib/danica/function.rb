module Danica
  class Function < Equation
    include Common
    include VariablesHolder
    include DSL
    include Expressable

    autoload :Name,    'danica/function/name'
    attr_accessor :name

    reset_variables

    delegate :to_f, to: :expression

    built_with(:function_block)

    class << self
      def build(*vars, &block)
        Class.new(self) do
          variables(*vars)

          private

          define_method :function_block do
            @function_block ||= instance_eval(&block) if block
          end
        end
      end

      def create(*vars, &block)
        build(*vars, &block).new
      end
    end

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

    def name
      containers_hash[:left] ||= Danica::Wrapper::Container.new Name.new(name: @name, variables: containers)
    end

    def expression
      @expression ||= Expression.build(:x) do
        x
      end.new(function_block)
    end

    def left
      name
    end

    def right
      expression
    end
  end
end
