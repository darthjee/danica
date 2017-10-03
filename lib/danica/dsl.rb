module Danica
  module DSL
    def self.register(method, clazz=nil)
      define_method method do |*args|
        clazz = "Danica::Operator::#{method.to_s.camelize}".constantize unless clazz
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
    DSL.register(method)
  end
  %i(
    number group negative
  ).each do |method|
    DSL.register(method, "Danica::Wrapper::#{method.to_s.camelize}".constantize)
  end
end
