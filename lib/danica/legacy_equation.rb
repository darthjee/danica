module Danica
  class LegacyEquation
    include Common
    include VariablesHolder

    variables :left, :right

    def initialize(*args)
      self.variables = args.flatten
    end

    def to(format)
      "#{left.to(format)} = #{right.to(format)}"
    end
  end
end

