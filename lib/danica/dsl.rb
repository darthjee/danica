module Danica
  module DSL
    class Inferator
      attr_reader :method, :claz, :base

      def initialize(method, claz=nil, base=nil)
        @method = method
        @claz = claz
        @base = base
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
        clazz = Inferator.new(method, clazz, base).clazz

        define_method method do |*args|
          clazz.new(*args)
        end
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
