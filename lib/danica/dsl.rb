module Danica
  module DSL
    def self.register(method, clazz=nil)
      define_method method do |*args|
        clazz = "Danica::#{method.to_s.camelize}".constantize unless clazz
        clazz.new(*args)
      end
    end

    def function(*variables, &block)
      Function.build(*variables, &block).new
    end
  end

  %i(
    sum product division sin cos power number
    squared_root exponential group negative
  ).each do |method|
    DSL.register(method)
  end
end
