module Danica
  class Function < Equation
    include Common
    include VariablesHolder
    include DSL

    autoload :Name,    'danica/function/name'
    attr_accessor :name

    reset_variables

    delegate :to_f, to: :expression

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

    def calculate(*args)
      vars_map = args.extract_options!
      vars_map = variables_value_hash.merge(vars_map)
      vars_map.each do |k, v|
        unless v && (v.is_a?(Integer) || v.valued?)
          vars_map[k] = args.shift
        end
      end

      self.class.new(vars_map).to_f
    end
  end
end
