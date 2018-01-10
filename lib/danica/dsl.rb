module Danica
  module DSL
    class << self
      def register_operator(method, clazz=nil)
        register(method, clazz, 'Danica::Operator')
      end

      def register_wrapper(method, clazz=nil)
        register(method, clazz, 'Danica::Wrapper')
      end

      def register(method, clazz=nil, base=nil)
        define_method method do |*args|
          clazz = [base.to_s, method.to_s.camelize].compact.join('::').constantize unless clazz
          clazz = [base, clazz.to_s].compact.join('::').constantize unless clazz.is_a? Class
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
