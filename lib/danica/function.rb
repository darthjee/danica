# frozen_string_literal: true

module Danica
  class Function
    autoload :Name, 'danica/function/name'

    include VariablesHolder
    include DSL
    include Expressable

    attr_writer :name

    built_with(:function_block)

    def self.for(expression_class)
      build(expression_class.variables_hash) do
        expression_class.new(variables_hash)
      end
    end

    def name
      Name.new(name: @name, variables: containers)
    end

    def to(format, **options)
      "#{name.to(format, **options)} = #{function_block.to(format, **options)}"
    end
  end
end
