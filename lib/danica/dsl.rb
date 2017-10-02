module Danica
  module DSL
    def self.register(method, clazz=nil)
      clazz = "Danica::#{method.to_s.camelize}".constantize unless clazz
      define_method method do |*args|
        clazz.new(*args)
      end
    end
  end

  %i(
    sum product division sin cos power number
    squared_root exponential group negative
  ).each do |method|
    DSL.register(method)
  end
end
