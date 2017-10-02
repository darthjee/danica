module Danica
  module DSL
    def self.register(method, clazz)
      DSL.send(:define_method, method) do |*args|
        clazz.new(*args)
      end
    end
  end

  DSL.register(:sum, Sum)
  DSL.register(:product, Product)
  DSL.register(:division, Division)
end
