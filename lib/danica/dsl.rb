module Danica
  module DSL
    class Builder
      attr_reader :instance, :method, :claz, :base

      def initialize(instance, method, claz=nil, base=nil)
        @instance = instance
        @method = method
        @claz = claz
        @base = base
      end

      def build
        clas = clazz
        instance.send(:define_method, method) do |*args|
          clas.new(*args)
        end
      end

      def clazz
        @clazz ||= build_clazz
      end

      def build_clazz
        return clazz_from_method unless claz
        return claz if claz.is_a? Class
        clazz_from_string
      end

      def clazz_from_method
        [base.to_s, method.to_s.camelize].compact.join('::').constantize
      end

      def clazz_from_string
        [base, claz.to_s].compact.join('::').constantize
      end
    end

    class << self
      def register_operator(method, clazz=nil)
        register(method, clazz, 'Danica::Operator')
      end

      def register_wrapper(method, clazz=nil)
        register(method, clazz, 'Danica::Wrapper')
      end

      def register(method, clazz=nil, base=nil)
        Builder.new(self, method, clazz, base).build
      end

      def build(&block)
        builder.instance_eval(&block)
      end

      private

      def builder
        @builder ||= Class.new do
          include DSL
        end.new
      end
    end

    def function(*variables, &block)
      Function.build(*variables, &block).new
    end
  end

  %i(
    addition multiplication division sin cos power
    squared_root exponential
  ).each do |method|
    DSL.register_operator(method)
  end

  %i(number group negative plus_minus variable constant).each do |method|
    DSL.register_wrapper(method)
  end

  DSL.register_wrapper  :num,     :Number
  DSL.register_operator :sum,     :Addition
  DSL.register_operator :product, :Multiplication
  DSL.register_operator :sqrt,    :SquaredRoot
end
