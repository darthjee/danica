module Danica
  module DSL
    def self.register(method, clazz=nil)
      clazz = "Danica::#{method.to_s.camelize}".constantize unless clazz
      DSL.send(:define_method, method) do |*args|
        clazz.new(*args)
      end
    end
  end

  DSL.register(:sum)
  DSL.register(:product)
  DSL.register(:division)
end
