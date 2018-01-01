module Danica
  class Function
    include Common
    include VariablesHolder
    include DSL
    include Expressable

    attr_accessor :name

    built_with(:function_block)

    def name
      LegacyFunction::Name.new(name: @name, variables: containers)
    end

    def to(*args)
      "#{name.to(*args)} = #{function_block.to(*args)}"
    end
  end
end

