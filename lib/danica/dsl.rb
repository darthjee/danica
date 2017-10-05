module Danica
  module DSL
    def self.register_operator(method, clazz=nil)
      register(method, clazz, 'Danica::Operator')
    end

    def self.register_wrapper(method, clazz=nil)
      register(method, clazz, 'Danica::Wrapper')
    end

    def self.register(method, clazz=nil, base=nil)
      define_method method do |*args|
        clazz = [base.to_s, method.to_s.camelize].compact.join('::').constantize unless clazz
        clazz = [base, clazz.to_s].compact.join('::').constantize unless clazz.is_a? Class
        clazz.new(*args)
      end
    end

    def function(*variables, &block)
      Function.build(*variables, &block).new
    end
  end

  %i(
    addition product division sin cos power
    squared_root exponential
  ).each do |method|
    DSL.register_operator(method)
  end

  %i(number group negative plus_minus).each do |method|
    DSL.register_wrapper(method)
  end

  DSL.register_operator :sum, :Addition
end

Danica.build do
  sum(1, 2)
end
