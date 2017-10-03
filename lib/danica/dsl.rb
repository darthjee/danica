module Danica
  module DSL
    def self.register_operator(method, clazz=nil)
      register(method, clazz, base='Danica::Operator')
    end

    def self.register_wrapper(method, clazz=nil)
      register(method, clazz, base='Danica::Wrapper')
    end

    def self.register(method, clazz=nil, base=nil)
      define_method method do |*args|
        clazz = [base.to_s, method.to_s.camelize].compact.join('::').constantize unless clazz
        clazz.new(*args)
      end
    end

    def function(*variables, &block)
      Function.build(*variables, &block).new
    end
  end

  %i(
    sum product division sin cos power
    squared_root exponential
  ).each do |method|
    DSL.register_operator(method)
  end

  %i(number group negative).each do |method|
    DSL.register_wrapper(method)
  end
end
