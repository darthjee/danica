module Danica
  class Function < LegacyEquation
    include Common
    include DSL
    include Expressable

    autoload :Name,    'danica/function/name'
    attr_accessor :name

    reset_variables

    built_with(:function_block)

    def name
      containers_hash[:left] ||= Danica::Wrapper::Container.new Name.new(name: @name, variables: containers)
    end

    def expression
      @expression ||= Expression.build(:x) do
        x
      end.new(function_block)
    end

    def left
      name
    end

    def right
      expression
    end
  end
end
